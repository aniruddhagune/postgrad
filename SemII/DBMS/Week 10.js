// Prelude. At the beginning, God created light.
// Then some snake offered an apple to two people and things have gone downhill ever since.

db.students.insertMany([
  {
    name: "Alice",
    mobile: "9876543210",
    age: 20,
    gender: "Female",
    department: "Computer Science",
    course: "B.Tech",
    semester: 4,
    cgpa: 8.9
  },
  {
    name: "Bob",
    mobile: "8765432109",
    age: 22,
    gender: "Male",
    department: "Mechanical Engineering",
    course: "B.Tech",
    semester: 6,
    cgpa: 7.4
  },
  {
    name: "Charlie",
    mobile: "7654321098",
    age: 21,
    gender: "Male",
    department: "Civil Engineering",
    course: "B.Tech",
    semester: 4,
    cgpa: 8.0
  },
  {
    name: "David",
    mobile: "6543210987",
    age: 23,
    gender: "Male",
    department: "Electrical Engineering",
    course: "B.Tech",
    semester: 6,
    cgpa: 6.5
  },
  {
    name: "Eve",
    mobile: "5432109876",
    age: 19,
    gender: "Female",
    department: "Computer Science",
    course: "B.Tech",
    semester: 2,
    cgpa: 9.2
  },
  {
    name: "Frank",
    mobile: "4321098765",
    age: 24,
    gender: "Male",
    department: "Computer Science",
    course: "M.Tech",
    semester: 1,
    cgpa: 7.8
  },
  {
    name: "Grace",
    mobile: "3210987654",
    age: 21,
    gender: "Female",
    department: "Electrical Engineering",
    course: "B.Tech",
    semester: 5,
    cgpa: 8.3
  },
  {
    name: "Hannah",
    mobile: "2109876543",
    age: 22,
    gender: "Female",
    department: "Mechanical Engineering",
    course: "B.Tech",
    semester: 7,
    cgpa: 7.6
  },
  {
    name: "Irene",
    mobile: "1098765432",
    age: 19,
    gender: "Female",
    department: "Computer Science",
    course: "B.Tech",
    semester: 1,
    cgpa: 9.0
  },
  {
    name: "Jack",
    mobile: "1987654321",
    age: 23,
    gender: "Male",
    department: "Chemical Engineering",
    course: "B.Tech",
    semester: 6,
    cgpa: 7.1
  },
  {
    name: "Kathy",
    mobile: "0876543210",
    age: 22,
    gender: "Female",
    department: "Civil Engineering",
    course: "B.Tech",
    semester: 5,
    cgpa: 8.4
  },
  {
    name: "Leo",
    mobile: "0765432109",
    age: 21,
    gender: "Male",
    department: "Electrical Engineering",
    course: "B.Tech",
    semester: 3,
    cgpa: 8.2
  },
  {
    name: "Mia",
    mobile: "0654321098",
    age: 20,
    gender: "Female",
    department: "Computer Science",
    course: "B.Tech",
    semester: 4,
    cgpa: 8.5
  },
  {
    name: "Nate",
    mobile: "0543210987",
    age: 24,
    gender: "Male",
    department: "Mechanical Engineering",
    course: "M.Tech",
    semester: 2,
    cgpa: 7.9
  },
  {
    name: "Olivia",
    mobile: "0432109876",
    age: 21,
    gender: "Female",
    department: "Mechanical Engineering",
    course: "B.Tech",
    semester: 3,
    cgpa: 8.6
  },
  {
    name: "Paul",
    mobile: "0321098765",
    age: 22,
    gender: "Male",
    department: "Computer Science",
    course: "B.Tech",
    semester: 5,
    cgpa: 9.1
  },
  {
    name: "Quincy",
    mobile: "0210987654",
    age: 20,
    gender: "Male",
    department: "Electrical Engineering",
    course: "B.Tech",
    semester: 2,
    cgpa: 8.7
  },
  {
    name: "Rachel",
    mobile: "0109876543",
    age: 23,
    gender: "Female",
    department: "Civil Engineering",
    course: "B.Tech",
    semester: 6,
    cgpa: 7.8
  },
  {
    name: "Steve",
    mobile: "0998765432",
    age: 22,
    gender: "Male",
    department: "Mechanical Engineering",
    course: "B.Tech",
    semester: 5,
    cgpa: 7.3
  }
]);


// 10. Illustration of Where Clause, AND, OR operations in MongoDB.

// WHERE (Shorthand)
db.students.find({ department: "Civil" });

// WHERE (Explicit)
db.students.find({ department: { $eq: "Civil" } });


// AND (Shorthand)
db.students.find({ gender: "Female", cgpa: { $gt: 8.5 } });

// AND (Explicit)
db.students.find({
  $and: [
    { gender: "Female" },
    { cgpa: { $gt: 8.5 } }
  ]
});


// OR has no shorthand. This is partly because of the nature of MongoDB and how it's written that the other two do.
db.students.find({
  $or: [
    { department: "Computer Science" },
    { semester: 8 }
  ]
});


// 11. Execute the Commands of MongoDB and operations in MongoDB : Insert, Query, Update, Delete and Projection.

//// Insert

// Insert: insertOne()
db.students.insertOne({
  name: "Tom",
  mobile: "1234567890",
  age: 22,
  gender: "Male",
  department: "Electrical Engineering",
  course: "B.Tech",
  semester: 5,
  cgpa: 7.9
});

// Insert: insertMany()
db.students.insertMany([
  {
    name: "Alice",
    mobile: "9876543210",
    age: 20,
    gender: "Female",
    department: "Computer Science",
    course: "B.Tech",
    semester: 4,
    cgpa: 8.9
  },
  {
    name: "John",
    mobile: "8765432109",
    age: 23,
    gender: "Male",
    department: "Mechanical Engineering",
    course: "B.Tech",
    semester: 7,
    cgpa: 7.6
  }
]);

//// Query

// Query: findOne() - returns only one object.
db.students.findOne({ name: "Alice" });

// Query: find()
db.students.find({ department: "Computer Science" });

//// Update

// Update: updateOne()
db.students.updateOne(
  { name: "Alice" },
  { $inc: { cgpa: 0.3 } }
);

// Update: updateMany()
db.students.updateMany(
  { department: "Computer Science" },
  { $inc: { cgpa: -0.2 } }
);

// Update: replaceOne() - Used to replace the entire object with a new one. It does however maintain the _id field.
db.students.replaceOne(
  { name: "Tom" }, 
  {
    name: "Tim",
    mobile: "1122334455",
    age: 24,
    gender: "Male",
    department: "Physics",
    course: "Ph.D.",
    semester: 6,
    cgpa: 8.7
  },
  { upsert: true }  // If no matching document is found, insert a new one
);

//// Delete

// deleteOne()
db.students.deleteOne({ name: "Tom" });

// deleteMany()
db.students.deleteMany({ cgpa: { $lt: 6.5 } });


//// Projection - Selecting specific data rather 

// Projection with specific fields inlcuded.
db.students.find({}, { _id: 0, name: 1, cgpa: 1 });

// Projection with specific fields excluded, and returning every other one.
db.students.find({}, { _id: 0, semester: 0, cgpa: 0});

// Projection with filter.
db.students.find({ department: "Computer Science" }, { name: 1, semester: 1 });
