package main

import (
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"github.com/gorilla/mux"
	"context"
	"reflect"
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
	Saveditems  []string       	 	`json:"saveditems,omitempty" bson:"saveditems,omitempty"`
	Listings  	[]string       		`json:"listings,omitempty" bson:"listings,omitempty"`
}

// Item object - use name field as the unique key. Note Image field is a base64 string of the image
type Item struct {
	ID        	primitive.ObjectID 	`json:"_id,omitempty" bson:"_id,omitempty"`
	Uid			string 				`json:"uid,omitempty" bson:"uid,omitempty"`
	Name 		string           	`json:"name,omitempty" bson:"name,omitempty"`
	Description string          	`json:"description,omitempty" bson:"description,omitempty"`
	Category	string           	`json:"category,omitempty" bson:"category,omitempty"`
	Image 		string 				`json:"image,omitempty" bson:"image,omitempty"`
}

// Listing object - use listing ID (lid) as unique key
type Listing struct {
	ID        	primitive.ObjectID 	`json:"_id,omitempty" bson:"_id,omitempty"`
	Uid		  	string 			 	`json:"uid,string,omitempty" bson:"uid,string,omitempty"`
	Itemid  	string 				`json:"itemid,omitempty" bson:"itemid,omitempty"`
	Useremail  	string 				`json:"useremail,omitempty" bson:"useremail,omitempty"`
	Location 	string 			 	`json:"location,omitempty" bson:"location,omitempty"`
	Active		string 				`json:"active,omitempty" bson:"active,omitempty"`
	Successful	string 				`json:"successful,omitempty" bson:"successful,omitempty"`
	Offers		[]Offer             `json:"offers,omitempty" bson:"offers,omitempty"`
}

// Offer object - intended to be nested in Listing
type Offer struct {
	Useremail	string 				`json:"useremail,omitempty" bson:"useremail,omitempty"`
	Price		string 				`json:"price,omitempty" bson:"price,omitempty"`
}

// Message object
type Message struct {
	ID        	primitive.ObjectID 	`json:"_id,omitempty" bson:"_id,omitempty"`
	Time		string 			 	`json:time,omitempty"" bson:"time,omitempty"`
	To		  	string 			 	`json:"to,omitempty" bson:"to,omitempty"`
	From	  	string 			 	`json:"from,omitempty" bson:"from,omitempty"`
	Text	  	string 			 	`json:"text,omitempty" bson:"text,omitempty"`	
}

// Deletion request json for DeleteItemEndpoint
type Delete struct {
	Uid 		string              `json:"uid"`
}

// Modify request json:struct for ModifyListingEndpoint
type ModifyListing struct {
	Uid 		string              `json:"uid"`
	Listings  	[]string       		`json:"listings,omitempty" bson:"listings,omitempty"`

}

// Modify request json:struct for ModifyuserEndpoint
type ModifyUser struct {
	Email	  	string             	`json:"email`
	Saveditems  []string       	 	`json:"saveditems,omitempty" bson:"saveditems,omitempty"`
	Listings  	[]string       		`json:"listings,omitempty" bson:"listings,omitempty"`
}

// Permanenty remove an item from database.
func DeleteItemEndpoint(response http.ResponseWriter, request *http.Request) {
	fmt.Println("Delete item DELETE request received.")  // remove in production
	response.Header().Set("content-type", "application/json")
	
	var del Delete
	_ = json.NewDecoder(request.Body).Decode(&del)
	uid := del.Uid
	
	var item Item
	collection := client.Database("hackathon_app").Collection("items")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	err := collection.FindOne(ctx, Item{Uid: uid}).Decode(&item)
	
	fmt.Println(item.ID)	// remove in production
	res, err := collection.DeleteOne(ctx, bson.M{"_id": item.ID})
	fmt.Println("DeleteOne Result TYPE:", reflect.TypeOf(res))
	if res.DeletedCount == 0 {
		fmt.Println("DeleteOne() document not found:", res)
	} else {
		fmt.Println("DeleteOne Result:", res)
		fmt.Println("DeleteOne TYPE:", reflect.TypeOf(res))
	}
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(item)
}


// Get all Items.
func GetAllItemsEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get all items GET request received.")  // remove in production
	var items []Item
	collection := client.Database("hackathon_app").Collection("items")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var item Item
		cursor.Decode(&item)
		items = append(items, item)
	}
	if err := cursor.Err(); err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(items)
}

// Return a single item by its uid.
func GetItemEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get single item GET request received.")  // remove in production
	params := mux.Vars(request)
	uid, _ := params["uid"]
	fmt.Println(params)	// remove in production
	var item Item
	collection := client.Database("hackathon_app").Collection("items")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	err := collection.FindOne(ctx, Item{Uid: uid}).Decode(&item)
	fmt.Println(Item{Uid: uid})	// remove in production
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(item)
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

// Create a new Item, write to DB collection "items.
func CreateItemEndpoint(response http.ResponseWriter, request *http.Request) {
	fmt.Println("Create item POST request received.")  // remove in production
	response.Header().Set("content-type", "application/json")
	var item Item
	_ = json.NewDecoder(request.Body).Decode(&item)
	fmt.Println(item)	// remove in production
	collection := client.Database("hackathon_app").Collection("items")
	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)
	result, _ := collection.InsertOne(ctx, item)
	fmt.Println(result)  // remove in production		
	json.NewEncoder(response).Encode(result)
}

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

// Return array of all users
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

// Create a new listing, write to db collection "listings"
func CreateListingEndpoint(response http.ResponseWriter, request *http.Request) {
	fmt.Println("Create listing POST request received.")  // remove in production
	response.Header().Set("content-type", "application/json")
	var listing Listing
	_ = json.NewDecoder(request.Body).Decode(&listing)
	fmt.Println(listing)	// remove in production
	collection := client.Database("hackathon_app").Collection("listings")
	ctx, _ := context.WithTimeout(context.Background(), 5*time.Second)
	result, _ := collection.InsertOne(ctx, listing)
	fmt.Println(result)  // remove in production
	json.NewEncoder(response).Encode(result)
}

func GetListingsEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get all listings GET request received.")  // remove in production
	var listings []Listing
	collection := client.Database("hackathon_app").Collection("listings")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	cursor, err := collection.Find(ctx, bson.M{})
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var listing Listing
		cursor.Decode(&listing)
		fmt.Println(listing)  // remove in production
		listings = append(listings, listing)
	}
	if err := cursor.Err(); err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(listings)
}

func GetListingEndpoint(response http.ResponseWriter, request *http.Request) {
	response.Header().Set("content-type", "application/json")
	fmt.Println("Get single listing GET request received.")  // remove in production
	params := mux.Vars(request)
	uid, _ := params["uid"]
	var listing Listing
	collection := client.Database("hackathon_app").Collection("listings")
	ctx, _ := context.WithTimeout(context.Background(), 30*time.Second)
	err := collection.FindOne(ctx, Listing{Uid: uid}).Decode(&listing)
	fmt.Println(Listing{Uid: uid})	// remove in production
	if err != nil {
		response.WriteHeader(http.StatusInternalServerError)
		response.Write([]byte(`{ "message": "` + err.Error() + `" }`))
		return
	}
	json.NewEncoder(response).Encode(listing)
}

func ModifyListingEndpoint(response http.ResponseWriter, request *http.Request) {}

func CreateMessageEndpoint(response http.ResponseWriter, request *http.Request) {}

func GetMessagesEndpoint(response http.ResponseWriter, request *http.Request) {}

func ModifyUserEndpoint(response http.ResponseWriter, request *http.Request) {}

func main() {
	fmt.Println("Vonex Hackathon App Server - Up-Cycling App")

	// MongoDB context and client 
	ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")
	client, _ = mongo.Connect(ctx, clientOptions)
	
	// Request router
	router := mux.NewRouter()
	
	// User endpoints
	router.HandleFunc("/user", CreateUserEndpoint).Methods("POST")
	router.HandleFunc("/users", GetUsersEndpoint).Methods("GET")
	router.HandleFunc("/user/{email}", GetUserEndpoint).Methods("GET")
	router.HandleFunc("/modifyuser", ModifyUserEndpoint).Methods("PUT")
	
	// Item endpoints
	router.HandleFunc("/item", CreateItemEndpoint).Methods("POST")
	router.HandleFunc("/items", GetAllItemsEndpoint).Methods("GET")
	router.HandleFunc("/item/{uid}", GetItemEndpoint).Methods("GET")
	router.HandleFunc("/deleteitem", DeleteItemEndpoint).Methods("DELETE")
	
	// Listing endpoints
	router.HandleFunc("/listing", CreateListingEndpoint).Methods("POST")
	router.HandleFunc("/listings", GetListingsEndpoint).Methods("GET")
	router.HandleFunc("/listing/{uid}", GetListingEndpoint).Methods("GET")
	router.HandleFunc("/modifylisting", ModifyListingEndpoint).Methods("PUT")

	// Message endpoints
	router.HandleFunc("/message", CreateMessageEndpoint).Methods("POST")
	router.HandleFunc("/messages/{email}", GetMessagesEndpoint).Methods("GET")

	// Port to serve
	http.ListenAndServe(":5005", router)
}