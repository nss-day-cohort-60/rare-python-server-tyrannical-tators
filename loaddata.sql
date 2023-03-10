CREATE TABLE "Users" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "first_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "bio" varchar,
  "username" varchar,
  "password" varchar,
  "profile_image_url" varchar,
  "created_on" date,
  "active" bit
);
-- The BIT data type is an integer value that accepts 0, 1, and NULL. BIT represents a boolean type with TRUE (1) and FALSE (0) values. String values 'TRUE' and 'FALSE' are also accepted and converted to 1 and 0.
-- The DATE data type: Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'

CREATE TABLE "DemotionQueue" (
  "action" varchar,
  "admin_id" INTEGER,
  "approver_one_id" INTEGER,
  FOREIGN KEY(`admin_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`approver_one_id`) REFERENCES `Users`(`id`),
  PRIMARY KEY (action, admin_id, approver_one_id)
);


CREATE TABLE "Subscriptions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "follower_id" INTEGER,
  "author_id" INTEGER,
  "created_on" date,
  FOREIGN KEY(`follower_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Posts" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "category_id" INTEGER,
  "title" varchar,
  "publication_date" date,
  "image_url" varchar,
  "content" varchar,
  "approved" bit,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`)
);

ALTER TABLE Posts
DROP COLUMN tag_id

CREATE TABLE "Comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "author_id" INTEGER,
  "content" varchar,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`author_id`) REFERENCES `Users`(`id`)
);

CREATE TABLE "Reactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar,
  "image_url" varchar
);

CREATE TABLE "PostReactions" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "user_id" INTEGER,
  "reaction_id" INTEGER,
  "post_id" INTEGER,
  FOREIGN KEY(`user_id`) REFERENCES `Users`(`id`),
  FOREIGN KEY(`reaction_id`) REFERENCES `Reactions`(`id`),
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`)
);

CREATE TABLE "Tags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

CREATE TABLE "PostTags" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "post_id" INTEGER,
  "tag_id" INTEGER,
  FOREIGN KEY(`post_id`) REFERENCES `Posts`(`id`),
  FOREIGN KEY(`tag_id`) REFERENCES `Tags`(`id`)
);

CREATE TABLE "Categories" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT,
  "label" varchar
);

UPDATE Posts
SET tag_id = 3 
WHERE id = 3;

INSERT INTO Posttags ('post_id', 'tag_id') VALUES (3, 3);

INSERT INTO Categories ('label') VALUES ('News');
INSERT INTO Tags ('label') VALUES ('JavaScript');
INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://pngtree.com/so/happy');

INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active') VALUES ('Mashed', 'Potato', 'mashed_potato@tatersrawesome.com', 'Mashed potatoes began as a simple accident but have risen to popularity with the addition of cream and butter.', 'mashedisbest', 'password', 'https://www.allrecipes.com/thmb/DINxGpxhBoi4b0hk3zbWpkPPYB8=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/24771-basic-mashed-potatoes-mfs321-158e1626bfeb48daadb4f25d737ffee9.jpg', '2023-01-25', 1);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active') VALUES ('Tater', 'Tot', 'tatertots4eva@tatersrawesome.com', 'Tater loves to be salted, dipped, smothered in sauce and enjoyed anywhere; fancy restaurant, moving cars, and everywhere in between.', 'tottie_is_a_hottie', 'password', 'https://midwestfoodieblog.com/wp-content/uploads/2022/06/FINAL-tater-tots-1-1200x1800.jpg', '2023-01-25', 1);
INSERT INTO Users ('first_name', 'last_name', 'email', 'bio', 'username', 'password', 'profile_image_url', 'created_on', 'active') VALUES ('Frenchie', 'Fries', 'ouifrenchie@tatersrawesome.com', 'Classic. Beloved. Even children who "don''t like potatoes" still love Frenchie.', 'pommes_frites', 'password', 'https://www.allrecipes.com/thmb/2DKPE5NB7c20ES4vhpwciKU3Low=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/French-Fries-4x3-1-2000-0a55bb658a0d41aca29f0ec4c8eba47c.jpg', '2023-01-25', 1);

INSERT INTO Categories ('label') VALUES ('Opinion');
INSERT INTO Categories ('label') VALUES ('Satire');

INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (2, 2, 'Taters gonna Tate', '2023-01-25', 'https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/1-tater-tots-funny-potato-michael-s.jpg', 'Tater tots are a classic and beloved snack food, and for good reason! Perfectly crispy on the outside yet soft and pillowy on the inside, tater tots are an iconic combination of potato, salt, and a touch of butter - irresistible. They are the ideal snack food for any gathering, be it a backyard barbecue or a night in with friends. For those who like to get creative in the kitchen, tater tots are incredibly versatile and easily lend themselves to a variety of recipes; they can be served in tacos, as a topping on pizza, or even as a base for your favorite dip. All in all, tater tots are an absolute classic with an irresistible flavor that can be enjoyed in a variety of ways.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (1, 1, 'Cream vs Milk', '2023-01-25', 'https://www.realsimple.com/thmb/isf4F7AdR_ICx3Ir0KRL9cJevZE=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/heavy-cream-vs-half-half-2000-4485a366faa5492a9e8e82c313936023.jpg', 'Milk and cream are both dairy products that can be used to give mashed potatoes a creamy, rich texture. Milk contains more water than cream, so it tends to make mashed potatoes lighter in texture. Cream has a higher fat content which helps to give mashed potatoes a richer, more luxurious texture. Both milk and cream can be used in a variety of flavors to create delicious mashed potatoes, but cream is slightly sweeter and can give mashed potatoes a richer flavor. Milk is better for those looking for a lighter texture or those who are trying to watch their calories, while cream is better for those looking for a richer flavor and texture.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (3, 3, 'La France est meilleure que l''Am??rique', '2023-01-25', 'https://www.planetware.com/wpimages/2020/02/france-in-pictures-beautiful-places-to-photograph-eiffel-tower.jpg', 'La France est souvent consid??r??e comme une destination sup??rieure en raison de sa culture dynamique, de sa riche histoire et de son art in??gal??. De son architecture ??poustouflante ?? sa cuisine de renomm??e mondiale, la France offre quelque chose pour tous les go??ts. De plus, le pays est r??put?? pour ses g??n??reuses lois sur les vacances, qui permettent aux citoyens de prendre jusqu''?? cinq semaines de cong??s pay??s par an. Enfin, le syst??me d''enseignement public fran??ais est consid??r?? comme l''un des meilleurs au monde, offrant aux ??l??ves un enseignement de qualit?? et un large ??ventail de ressources et d''opportunit??s p??dagogiques. Ces facteurs, combin??s ?? sa r??putation de destination romantique et ?? la mode, font de la France un choix populaire pour les touristes ?? la recherche d''une exp??rience unique et agr??able.', 1);

INSERT INTO Tags ('label') VALUES ('Python');
INSERT INTO Tags ('label') VALUES ('Potato');

DELETE FROM Reactions WHERE id = 1;

INSERT INTO Reactions ('label', 'image_url') VALUES ('happy', 'https://w7.pngwing.com/pngs/698/250/png-transparent-smiley-emoji-blushing-emoji-smiley-face-smile-face-smiley-sticker.png');
INSERT INTO Reactions ('label', 'image_url') VALUES ('like', 'https://www.pngfind.com/pngs/m/682-6827427_transparent-thumb-up-emoji-png-thumbs-up-apple.png');
INSERT INTO Reactions ('label', 'image_url') VALUES ('love', 'https://www.clipartmax.com/png/middle/124-1245735_heart-emoji-transparent-background.png');
INSERT INTO Reactions ('label', 'image_url') VALUES ('sad', 'https://toppng.com/uploads/preview/sad-face-transparent-png-crying-emoji-transparent-background-11562873850hiicomfwuq.png');
INSERT INTO Reactions ('label', 'image_url') VALUES ('wow', 'https://e1.pngegg.com/pngimages/477/616/png-clipart-emoji-sticker-wow-emoji-illustration-thumbnail.png');


INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (1, 1, 'So good!');
INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (1, 2, 'The best content on the web!');
INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (2, 1, 'Very enlightening.');
INSERT INTO Comments ('post_id', 'author_id', 'content') VALUES (2, 2, 'So glad I came across this article!');

INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') Values (1, 2, 2023-01-30);
INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') Values (1, 3, 2023-01-30);
INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') Values (1, 4, 2023-01-30);
INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') Values (1, 5, 2023-01-30);

SELECT DISTINCT p.title, p.user_id, u.first_name, u.last_name, u.id, p.user_id, s.follower_id
FROM posts p
JOIN users u
ON p.user_id = u.id
JOIN Subscriptions s
ON s.author_id = u.id
WHERE s.author_id IN (2, 3, 4, 5);

SELECT DISTINCT
    p.id,
    p.user_id,
    p.category_id,
    p.title,
    p.publication_date,
    p.image_url,
    p.content,
    p.approved,
    u.first_name,
    u.last_name,
    u.username,
    c.label,
    subscriptions.follower_id
FROM posts p
JOIN subscriptions
  ON p.user_id = Subscriptions.author_id
JOIN users u
    ON u.id = p.user_id
JOIN categories c
    on c.id = p.category_id
WHERE p.user_id = Subscriptions.author_id AND Subscriptions.follower_id = 1;

INSERT INTO Subscriptions ('follower_id', 'author_id', 'created_on') VALUES (1, 2, '2023-01-25')

INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (4, 3, 'Category 3 Title', '2023-01-25', 'https://www.allrecipes.com/thmb/c_2gXiAwkO6u1UJCY-1eAVCy0h0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/54679_perfect-baked-potato-Rita-1x1-1-91711252bb3740088c8ea55c5f9bef1c.jpg', 'Category 3 is an important concept in many disciplines, including science, engineering, and economics. It is a classification system that is used to group, organize, and describe related items. Category 3 can be used to identify similar characteristics in objects, ideas, and processes, as well as to create hierarchy and structure for analyzing data. It can also help to identify patterns, trends, and correlations between different elements. Category 3 can be a powerful tool for understanding complex topics and making better decisions.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (5, 4, 'Category 4 Title', '2023-01-27', 'https://twokooksinthekitchen.com/wp-content/uploads/2020/09/crispy-oven-roasted-potatoes.jpg', 'Member Category 4 is a broad term that covers a variety of topics, ranging from business to science and technology. Professionals in this field must be knowledgeable about a wide range of topics in order to stay up-to-date with the ever-changing environment. It is important for individuals in this category to have the latest trends and technologies at their fingertips in order to create successful projects and products. Additionally, they need to have a high level of creativity and problem-solving skills to come up with innovative solutions. Category 4 professionals are an invaluable asset to any organization and are essential for achieving success.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (1, 5, 'Category 5 Title', '2023-01-28', 'https://keviniscooking.com/wp-content/uploads/2021/02/Potatoes-Hasselback-square-1000x1000.jpg', 'Hasselback potatoes are a unique and tasty way to prepare potatoes. The potatoes are sliced thinly, almost all the way through, and then brushed with butter and herbs before being cooked in the oven. The result is a crispy outside and a fluffy and creamy inside. Hasselback potatoes are a great side dish for', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (2, 6, 'Category 6 Title', '2023-01-29', 'https://bakeitwithlove.com/wp-content/uploads/2022/09/Best-potato-for-baking-potatoes-or-making-twice-baked-potatoes.jpg', 'Twice baked potatoes are a delicious and versatile side dish. They are made by baking a potato, scooping out the insides and mixing them with creamy butter, sharp cheddar cheese, and other delicious ingredients like bacon, jalapenos, and chives. The mixture is then spooned back into the potato skins, topped with more cheese and baked until golden and crispy. The result is a creamy, flavorful potato that is a crowd-pleaser for any gathering. Plus, they''re easy to make and can be prepped ahead of time for a no-fuss side dish.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (3, 7, 'Category 7 Title', '2023-01-30', 'https://preppykitchen.com/wp-content/uploads/2022/10/Smashed-Potatoes-Feature.jpg', 'Smashed potatoes make for a delicious side dish that can compliment any entr??e. To make them, start by boiling a few potatoes in salted water until they are soft. Drain them, return them to the pot, and use a potato masher to break them up. Add a pat of butter and some garlic, and season to taste with salt, pepper, and herbs. For a rustic version, transfer the potatoes to an oven-safe dish and bake in a preheated 375-degree oven for 15 minutes. Serve hot, as a side dish for steak, grilled chicken, or fish.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (4, 8, 'Category 8 Title', '2023-01-31', 'https://www.tasteofhome.com/wp-content/uploads/2022/03/Potatoes-Lyonnaise_EXPS_TOHAM22_266867_E11_10_4b.jpg', 'Potatoes Lyonnaise is a classic French dish made with potatoes, onions, butter, and herbs. The dish is usually served as a side, but can also be enjoyed as a main. The potatoes are first boiled until they are tender, then sliced and fried in oil and butter with onions. The combination of the onions and potatoes creates a delicious flavor, while the herbs add an extra layer of flavor. Potatoes Lyonnaise is a great way to add some French flair to any meal.', 1);
INSERT INTO Posts ('user_id', 'category_id', 'title', 'publication_date', 'image_url', 'content', 'approved') VALUES (5, 9, 'Category 9 Title', '2023-02-01', 'https://images-gmi-pmc.edge-generalmills.com/63aa42b4-cfbe-4054-94e3-e595ee2731ea.jpg', 'Potatoes Anna is a classic French dish that is simple to prepare and utterly delicious. The potatoes are cooked in a shallow dish, with butter, salt and pepper, and occasionally some herbs such as thyme. The potatoes are layered in the dish, beginning with a layer of butter and onion, then potatoes and more butter, and so on until the dish is filled. Then the potatoes are cooked at a high temperature until they are golden and tender. A classic accompaniment to this dish is a salad, but it can also be served as a side dish with a variety of meats. The creamy texture of the potatoes and the delicious buttery flavour make this dish a real winner.', 1);

SELECT
    p.id,
    p.user_id,
    p.category_id,
    p.title,
    p.publication_date,
    p.image_url,
    p.content,
    p.approved,
    u.first_name,
    u.last_name,
    u.username,
    c.id cat_id,
    c.label cat_label,
    pt.tag_id,
    pt.post_id, 
    t.id, 
    t.label
FROM posts p
JOIN users u
    ON u.id = p.user_id
JOIN categories c
    on c.id = p.category_id
JOIN posttags pt
    ON pt.post_id = p.id
JOIN tags t 
    ON t.id = pt.tag_id

DELETE FROM Posts WHERE id IN (16, 17, 18, 19, 20);
