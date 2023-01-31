import sqlite3
import json
from datetime import datetime
from models import Post, Category, Tag, User, Subscription, Comment

def all(resource, key, value):
    # Open a connection to the database
    with sqlite3.connect("./db.sqlite3") as conn:

        # Just use these. It's a Black Box.
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        if resource == 'categories':
            db_cursor.execute("""
            SELECT
                c.id,
                c.label
            FROM categories c
            ORDER BY c.label ASC
            """)

            # Initialize an empty list to hold all category representations
            categories = []

            # Convert rows of data into a Python list
            dataset = db_cursor.fetchall()

            # Iterate list of data returned from database
            for row in dataset:

                # Create an category instance from the current row.
                # Note that the database fields are specified in
                # exact order of the parameters defined in the
                # Category class above.
                category = Category(row['id'], row['label'])

                categories.append(category.__dict__)

            return categories

        if resource == 'tags':
            db_cursor.execute("""
            SELECT
                t.id,
                t.label
            FROM tags t
            ORDER By t.label ASC
            
            """)

            # Initialize an empty list to hold all tag representations
            tags = []

            # Convert rows of data into a Python list
            dataset = db_cursor.fetchall()

            # Iterate list of data returned from database
            for row in dataset:

                # Create an tag instance from the current row.
                # Note that the database fields are specified in
                # exact order of the parameters defined in the
                # tag class above.
                tag = Tag(row['id'], row['label'])

                tags.append(tag.__dict__)

            return tags
        #confirms resource
        if resource == 'posts':
            sort_by = ""
            where_clause = ""
            #confirms query key
            if key == "_sortBy":
                #confirms query value
                if value == 'user_id':
                    sort_by = " ORDER BY user_id"
                elif value == "category_id":
                    sort_by = "ORDER BY category_id"
                elif value == 'publication_date':
                    sort_by = 'ORDER BY publication_date DESC'
            elif key == "user_id":
                where_clause = f"WHERE p.user_id = {value}"
            elif key == "category_id":
                where_clause = f"WHERE p.category_id = {value}"
                
            sql_string = f"""
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
                c.label
            FROM posts p
            JOIN users u
                ON u.id = p.user_id
            JOIN categories c
                on c.id = p.category_id
            {where_clause}
            {sort_by}
            """
            db_cursor.execute(sql_string)

            # Initialize an empty list to hold all post representations
            posts = []

            # Convert rows of data into a Python list
            dataset = db_cursor.fetchall()

            # Iterate list of data returned from database
            for row in dataset:

                # Create an post instance from the current row.
                # Note that the database fields are specified in
                # exact order of the parameters defined in the
                # Post class above.
                post = Post(row['id'], row['user_id'], row['category_id'],
                                row['title'], row['publication_date'], row['image_url'],
                                row['content'], row['approved'])
                user = User(row['id'], row['first_name'], row['last_name'], None, None, row['username'], None, None, None, None)
                category = Category(row['id'], row['label'])
                post.user = user.__dict__
                post.category = category.__dict__
                posts.append(post.__dict__)

            return posts

        if resource == 'users':

            db_cursor.execute("""
            SELECT
                u.id,
                u.first_name,
                u.last_name,
                u.email,
                u.bio,
                u.username,
                u.password,
                u.profile_image_url,
                u.created_on,
                u.active
            FROM users u
            ORDER BY u.username ASC
            """)

            # Initialize an empty list to hold all user representations
            users = []

            # Convert rows of data into a Python list
            dataset = db_cursor.fetchall()

            # Iterate list of data returned from database
            for row in dataset:

                # Create an user instance from the current row.
                # Note that the database fields are specified in
                # exact order of the parameters defined in the
                # User class above.
                user = User(row['id'], row['first_name'], row['last_name'],
                            row['email'], row['bio'], row['username'],
                            row['password'], row['profile_image_url'], row['created_on'],
                            row['active'])

                users.append(user.__dict__)

            return users


def single(resource, id):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        if resource == 'posts':
            db_cursor.execute("""
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
                c.label
            FROM posts p
            JOIN users u
                ON u.id = p.user_id
            JOIN categories c
                on c.id = p.category_id
            WHERE p.id = ?
            """, (id, ))

            # Load the single result into memory
            data = db_cursor.fetchone()

            if data is None:
                return None

            # Create a post instance from the data
            post = Post(data['id'], data['user_id'], data['category_id'],
                                data['title'], data['publication_date'], data['image_url'],
                                data['content'], data['approved'])
            user = User(data['id'], data['first_name'], data['last_name'], None, None, data['username'], None, None, None, None)
            category = Category(data['id'], data['label'])
            post.author = user.__dict__
            post.category = category.__dict__

            return post.__dict__

        if resource == 'users':
            db_cursor.execute("""
            SELECT
                u.id,
                u.first_name,
                u.last_name,
                u.email,
                u.bio,
                u.username,
                u.password,
                u.profile_image_url,
                u.created_on,
                u.active
            FROM users u
            WHERE u.id = ?
            """, (id, ))

            # Load the single result into memory
            data = db_cursor.fetchone()

            if data is None:
                return None

            # Create a user instance from the data
            user = User(data['id'], data['first_name'], data['last_name'],
                        data['email'], data['bio'], data['username'],
                        data['password'], data['profile_image_url'], data['created_on'],
                        data['active'])

            return user.__dict__

def edit_all(resource, id, post_body):
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()

        rows_affected = 0

        if resource == "posts":
            db_cursor.execute("""
            UPDATE posts
                SET
                    category_id = ?,
                    title = ?,
                    image_url = ?,
                    content = ?
            WHERE id = ?
            """, (post_body["category_id"], post_body["title"], post_body["image_url"], post_body["content"], id))

            rows_affected = db_cursor.rowcount

    if rows_affected == 0:
        return False
    else:
        return True




def delete_all(resource, id):
    #connect to database
    with sqlite3.connect("./db.sqlite3") as conn:
        #create cursor object
        db_cursor = conn.cursor()
        #confirm resource to verify table from which to delete
        if resource == "posts":
            db_cursor.execute("""
            DELETE FROM posts
            WHERE id=?
            """, (id,))

def get_comments_by_post(value):
    with sqlite3.connect("./db.sqlite3") as conn:
        conn.row_factory = sqlite3.Row
        db_cursor = conn.cursor()

        db_cursor.execute("""
        SELECT
            c.id,
            c.post_id,
            c.author_id,
            c.content,
            u.first_name,
            u.last_name,
            u.username
        FROM comments c
        JOIN users u
        ON c.author_id = u.id
        WHERE c.post_id = ?
        """, (value, ))

        comments = []
        dataset = db_cursor.fetchall()

        for row in dataset:
            comment = Comment(
                row['id'], row['post_id'], row['author_id'], row['content'])

            user = User(row['id'], row['first_name'], row['last_name'], None, None, row['username'], None, None, None, None)

            comment.user = user.__dict__
            comments.append(comment.__dict__)

    return comments

def create(resource, new_data):
    """Adds new resource to the database when they click submit
    Args:
        resource (dictionary): The dictionary passed to the post request
    Returns:
        json string
    """
    with sqlite3.connect("./db.sqlite3") as conn:
        db_cursor = conn.cursor()
        if resource == 'subscriptions':
            db_cursor.execute("""
            INSERT INTO Subscriptions
                (follower_id, author_id, created_on)
            VALUES
                (?,?,?);
            """, (new_data['follower_id'], new_data['author_id'], datetime.now() ))

        elif resource == 'posts':
            db_cursor.execute("""
            INSERT INTO Posts
                ( user_id, category_id, title, publication_date, image_url, content, approved )
            VALUES
                ( ?, ?, ?, ?, ?, ?, ?);
            """, (new_data['user_id'], new_data['category_id'],
                new_data['title'], new_data["publication_date"],
                new_data['image_url'], new_data['content'], new_data['approved'] ))

        id = db_cursor.lastrowid

        new_data['id'] = id

        return json.dumps(new_data)
