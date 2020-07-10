# PostgreSQL - Express - Vue (Vuetify) - NodeJS

The project basically consists of having two types of users: professors and students, professors can create courses and add their own assignments for each of the courses, on the other hand, students can join courses created by professors and make a delivery for each of the assignments, it is worth mentioning that professors also have access to a list of all students who have maked a delivery for any assignment. This is a very basic practical example to get started in the world of web development with frameworks.

You can watch the full youtube tutorial on how to make this practical example step by step [here](https://www.youtube.com/watch?v=7c4fgGNswTA&list=PL3f738vgxpbj9fKW-rtmV0xcjo84WqZXy)

> pevn-be

This folder contains all the backend of the project but also in its public folder it has all the frontend that is generated when you run `$ npm run build` in a vue project, this makes you can see the whole project when you run the `$ npm run babel` script

> pevn-fe

This folder contains the whole frontend of the project made with Vue and has a connection to our api through axios which is in the `pevn-be` folder so make sure that when you run the `$ npm run serve` script you first start the api by running `$ npm run babel` from the `pevn-be` folder.


Please do not forget this
```
npm install
```
## Views

### SignUp
![SignUp](https://user-images.githubusercontent.com/67696829/87164998-1feda000-c28f-11ea-9829-e8bd726a8b4e.png)

### SignIn
![SignIn](https://user-images.githubusercontent.com/67696829/87165058-38f65100-c28f-11ea-953b-84b2cfcb72f6.png)


### Professor's views
#### Courses
![professor-courses](https://user-images.githubusercontent.com/67696829/87165887-5f68bc00-c290-11ea-9f10-3a3eb970a796.png)

#### Assignments
![professor-assignments](https://user-images.githubusercontent.com/67696829/87166372-1b29eb80-c291-11ea-9104-146e77f3923b.png)

#### Deliveries
![professor-deliveries](https://user-images.githubusercontent.com/67696829/87166475-401e5e80-c291-11ea-912a-0c3e06284ce5.png)


### Student's views
#### All courses
![all-courses](https://user-images.githubusercontent.com/67696829/87167052-08fc7d00-c292-11ea-813c-7c46a176c398.png)

#### My courses
![my-courses](https://user-images.githubusercontent.com/67696829/87167151-26c9e200-c292-11ea-9a8e-eade8fff3e24.png)

#### Assignments
![assignments](https://user-images.githubusercontent.com/67696829/87167228-44974700-c292-11ea-89d5-08d5f8b18fd4.png)
