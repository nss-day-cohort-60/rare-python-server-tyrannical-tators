# Rare Server: The Publishing Platform for the Discerning Writer

## Project Overview:
Rare Publishing is a Full-Stack group project with collaboration from students in Cohort 60 of Nashville Software School.
Rare Publishing was built in two sprints, with this repo being the Python server built in the first 5-day sprint, it no longer works with the current [client code](https://github.com/nss-day-cohort-60/rare-client-tenacious-tators) as is, but functionality is still able to be tested and viewed using an API platform, the team used Postman and Thunderclient VS Code Extension, or you can view the full stack app using the client code at [this point](https://github.com/nss-day-cohort-60/rare-client-tenacious-tators/tree/dc8457498218a9ed8d8edc74b72f877b618b9d10) in it's repository.
The server was eventually re-built using [Django Rest](https://github.com/nss-day-cohort-60/django-taters-api) framework, and that repo fully supports the current client code.


## Primary Features:
The Goal of this web app is to allow authors to create blogposts.
Authors can also view other's blogposts and their own in list form as well as in detail.
They can edit and delete if they no longer like their blogposts.
They can also create and delete categories that they can then assign to a blogpost, blogposts can be viewed by category.
Tags can be created, edited, and deleted by any author and any user has the ability to create, edit, and delete their own comments.
Users can react to blogposts using predetermined emojis that keep a running count of reactions to that specific post.
Users can subscribe and unsubscribe to other users/authors.


## Target Audience:
People who want to share ideas, opinions, topics, thoughts, and current events.


## Purpose and problems it solves:
It's a mutual space for anyone that wants to share and read other's ideas.
Instead of searching Google you can now go to this site to read opinions(totally not like Twitter or Facebook).

## Demo Video
[![Watch the demo video](https://res.cloudinary.com/dry2hcdx9/image/upload/v1677792867/Screen_Shot_2023-03-02_at_3.30.58_PM_s4i04j.png)](https://drive.google.com/file/d/1j4MhPk-8XAOcEW-BVWEF81ohGrAFal73/view?usp=share_link)


## Retro Video
[![Watch the retro video](https://res.cloudinary.com/dry2hcdx9/image/upload/v1677793150/Screen_Shot_2023-03-02_at_3.38.55_PM_ghme1w.png)](https://drive.google.com/file/d/1kG1yDDLWngAm51NSc5_jmHO6EdU72DBR/view)




## Getting Started:
1. In the terminal, create a directory
```bash
cd <new directory name>
```

2. Run 
```bash
git clone git@github.com:nss-day-cohort-60/rare-python-server-tyrannical-tators
```

3. Test Server with requests
```
GET
http://localhost:8088/users
http://localhost:8088/categories
http://localhost:8088/posts
http://localhost:8088/tags
http://localhost:8088/subscriptions
```
```
GET
http://localhost:8088/users/1
```
```
POST
http://localhost:8088/users
```
```json
{
    "first_name": "Jessica",
    "last_name": "Meeker",
    "email": "jmeek@gmail.com",
    "bio": "asldkfjsdoifjasdfds sdjifoa dsfjaiosdf sa jdiaosf ",
    "username": "jesmeeker",
    "password": "password",
    "profile_image_url": null
 }
```
```
POST
http://localhost:8088/tags
```
```json
{
    "label": "Jack"
}
```
```
POST
http://localhost:8088/categories
```
```json
{
    "label": "Sports"
}
```
```
POST
http://localhost:8088/posts
```
```json
{
    "user_id": 3,
    "category_id": 3,
    "title": "La France est meilleure que l'Amérique",
    "publication_date": "2023-01-25",
    "image_url": "https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg",
    "content": "La France est souvent considérée comme une destination supérieure en raison de sa culture dynamique, de sa riche histoire et de son art inégalé. De son architecture époustouflante à sa cuisine de renommée mondiale, la France offre quelque chose pour tous les goûts. De plus, le pays est réputé pour ses généreuses lois sur les vacances, qui permettent aux citoyens de prendre jusqu'à cinq semaines de congés payés par an. Enfin, le système d'enseignement public français est considéré comme l'un des meilleurs au monde, offrant aux élèves un enseignement de qualité et un large éventail de ressources et d'opportunités pédagogiques. Ces facteurs, combinés à sa réputation de destination romantique et à la mode, font de la France un choix populaire pour les touristes à la recherche d'une expérience unique et agréable.",
    "approved": 1,
    "category_id": 1
}
```
## Tech Stack

![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![PYTHON](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

