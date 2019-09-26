package main

import (
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"github.com/gorilla/mux"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

var client *mongo.Client

// User object - use email field as the unique key
type User struct {
	ID        	primitive.ObjectID 	`json:"_id,omitempty" bson:"_id,omitempty"`
	Email	  	string             	`json:"email,omitempty" bson:"email,omitempty"`
	Firstname 	string             	`json:"firstname,omitempty" bson:"firstname,omitempty"`
	Lastname  	string             	`json:"lastname,omitempty" bson:"lastname,omitempty"`
	Password  	string             	`json:"password,omitempty" bson:"password,omitempty"`
	Picker	  	string             	`json:"picker,omitempty" bson:"picker,omitempty"`
	Packer	  	string             	`json:"packer,omitempty" bson:"packer,omitempty"`
	Fb			string 				`json:"fb,omitempty" bson:"fb,omitempty"`
	Insta 		string 				`json:"insta,omitempty" bson:"insta,omitempty"`
	Saveditems  []int       	 	`json:"saveditems,omitempty" bson:"saveditems,omitempty"`
	Listings  	[]int        		`json:"listings,omitempty" bson:"listings,omitempty"`
}

// Item object - use name field as the unique key
type Item struct {
	ID        	primitive.ObjectID 	`json:"_id" bson:"_id"`
	UID			int 				`json:"uid" bson:"uid"`
	Name 		string           	`json:"name" bson:"name"`
	Description string          	`json:"description" bson:"description"`
	Category	string           	`json:"category" bson:"category"`
}

// Listing object - use listing ID (lid) as unique key
type Listing struct {
	ID        	primitive.ObjectID 	`json:"_id" bson:"_id"`
	UID		  	int 			 	`json:"LID" bson:"LID"`
	Location 	string 			 	`json:"location" bson:"location"`
	Active		string 				`json:"active" bson:"active"`
	Successful	string 				`json:"successful" bson:"successful"`
	Item  		*Item 				`json:"item" bson:"item"`
}

// Message object - use message ID as unique key
type Message struct {
	ID        	primitive.ObjectID 	`json:"_id" bson:"_id"`
	Time		string 			 	`json:time"" bson:"time"`
	To		  	string 			 	`json:"to" bson:"to"`
	From	  	string 			 	`json:"from" bson:"from"`
	Text	  	string 			 	`json:"text" bson:"text"`	
}


// Permanenty remove an item from database.
func DeleteItemEndpoint(response http.ResponseWriter, request *http.Request) {}

// Create a new Item.
func CreateItemEndpoint(response http.ResponseWriter, request *http.Request) {}

// Get all Items.
func GetAllItemsEndpoint(response http.ResponseWriter, request *http.Request) {}

// Get a single item by its uid.
func GetItemEndpoint(response http.ResponseWriter, request *http.Request) {}

// Delete a user account.
func DeleteUserEndpoint(response http.ResponseWriter, request *http.Request) {}

// Create a new user, write to db collection "users"
func CreateUserEndpoint(response http.ResponseWriter, request *http.Request) {
	fmt.Println("Create user POST request received.")  // remove in production
	response.Header().Set("content-type", "application/json")
	var user User
	_ = json.NewDecoder(request.Body).Decode(&user)
	fmt.Println(user)	// remove in production
	collection := client.Database("hackathon_app").Collection("users")
	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)
	result, _ := collection.InsertOne(ctx, user)
	
	fmt.Println(result)  // remove in production
		
	json.NewEncoder(response).Encode(result)
}

// Returns a list of all users
func GetUsersEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get all users GET request received.")  // remove in production
	var users []User
	collection := client.Database("hackathon_app").Collection("users")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var user User
		cursor.Decode(&user)
		users = append(users, user)
	}
	if err := cursor.Err(); err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(users)
}

// Return user where email matches user[email]
func GetUserEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get single user GET request received.")  // remove in production
	params := mux.Vars(request)
	email, _ := params["email"]
	fmt.Println(params)	// remove in production
	var user User
	collection := client.Database("hackathon_app").Collection("users")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	err := collection.FindOne(ctx, User{Email: email}).Decode(&user)
	fmt.Println(User{Email: email})	// remove in production
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(user)
}

func main() {
	fmt.Println("Starting server...")
	ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")
	client, _ = mongo.Connect(ctx, clientOptions)
	router := mux.NewRouter()
	router.HandleFunc("/user", CreateUserEndpoint).Methods("POST")
	router.HandleFunc("/users", GetUsersEndpoint).Methods("GET")
	router.HandleFunc("/user/{email}", GetUserEndpoint).Methods("GET")
	http.ListenAndServe(":5005", router)
}