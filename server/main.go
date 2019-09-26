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

// Item object
type Item struct {
	ID        	primitive.ObjectID 	`json:"_id,omitempty" bson:"_id,omitempty"`
	Name 		string           	`json:"name,omitempty" bson:"name,omitempty"`
	Description string          	`json:"description,omitempty" bson:"description,omitempty"`
	Stock 		string           	`json:"stock,omitempty" bson:"stock,omitempty"`
}

// User object
type User struct {
	ID        primitive.ObjectID `json:"_id,omitempty" bson:"_id,omitempty"`
	Email	  string             `json:"email,omitempty" bson:"email,omitempty"`
	Firstname string             `json:"firstname,omitempty" bson:"firstname,omitempty"`
	Lastname  string             `json:"lastname,omitempty" bson:"lastname,omitempty"`
	Password  string             `json:"password,omitempty" bson:"password,omitempty"`
}

// TBC. Maybe get all purchases for a user.
func ExtraAPIEndpoint(response http.ResponseWriter, request *http.Request) {}

// Get all inventory
func GetAllInventoryEndpoint(response http.ResponseWriter, request *http.Request) {}

// Return items that match search term
func FindInventoryItemEndpoint(response http.ResponseWriter, request *http.Request) {}

// Permanenty remove an item from database
func DeleteInventoryEndpoint(response http.ResponseWriter, request *http.Request) {}

// Increase or decrease inventory levels for given item
func ModifyInventoryEndpoint(response http.ResponseWriter, request *http.Request) {}

// Create a new user, write to db collection "users"
func CreateUserEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	var user User
	_ = json.NewDecoder(request.Body).Decode(&user)
	fmt.Println(user)	// remove in production
	collection := client.Database("hackathon_app").Collection("users")
	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)
	result, _ := collection.InsertOne(ctx, user)
	json.NewEncoder(response).Encode(result)
	fmt.Println(result)  // remove in production
}

// Returns a list of all users
func GetUsersEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println(response)	// remove in production
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