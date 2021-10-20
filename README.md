# Analytics
A macOS Framework that provides tracking events for creating a basic analytics system.


In this exercise, we will build a basic macOS Framework with TDD to create analytics. We choose a macOS Framework to build because our logic doesn't have any platform specific details. This means we should be able to plug it in any OS platforms.

Our goal is that we want to know about some specific events, maybe we should call them event types which will make more sense later, when they occurred and how many times they did. 

Before coding, what is an event, an event type and how this framework will be used? It is important to understand because if we assume things we could end up in a bad complex situtation.

We will call our data model Event and an event model can contain event types and event types count depending on their dates.

## Event types are just namespaces. 
String type can be used or for better we can use enum type. String type is a class in Swift which means object type will be instantiated for its usage but for just a namespace instantiation would be much, so enums are better options to use.e.

## What is our task?
We want to achieve;

1- When a user signs-in, we want to capture the date of the event type and update its count.
2- When a user creates a task, we want to capture the date of the event type and update its count.
3- When a user completes a task, we want to capture the date of the event type and update its count.
4- We want to access the event types with a provided date, So we can see all accoured events on a specific date.

As we can see on the above requirements, we need 3 different event type to track. 
1- UserSignedIn
2- TaskCreated
3- TaskCompleted

## We can create our own data structure to support our logic. 
We can try different data models to see which one suites best for us. 

We can create an typealias for our Event data model. 

We can create our own data structure to support our logic. 
We can try different data models to see which one suites best for us. 

We can create an typealias for our Event data model. 
`typealias Event = [Date: [String : Int]]`

But if we go with above data model, it could be too much to handle for us in the future because we want to know about creation date for a specific event type. So somehow we have to compare the dates to see if they are the same day or not. Also using a String type for the event type name is not that good practice. Like we said we need to instantiate the String type.

So to make our job little easier, we can use below data model. 

`typealias Event = [String: [EventType : Int]]`

So this means we need EventType enum for event types names  and also have to handle conversion from Date type to String type. 

With this data model , we will have something like this; 
`[
"10/19/2021": [UserSignedIn: 1, TaskCreated: 2],
"10/20/2021": [TaskCompleted: 1],
...
]`

Date format: mm/dd/yy

Also with this data model, we can easily check if the date already exist or not, if it is we can go and find it to update its count.
