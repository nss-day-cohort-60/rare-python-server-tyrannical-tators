import sqlite3
import json
from models import Post, Category, Tag, User

def all(resource):
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
                p.approved
            FROM posts p
            """)

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
                p.approved
            FROM posts p
            WHERE p.id = ?
            """, ( id, ))

            # Load the single result into memory
            data = db_cursor.fetchone()

            if data is None:
                return None

            # Create a post instance from the data
            post = Post(data['id'], data['user_id'], data['category_id'],
                            data['title'], data['publication_date'], data['image_url'],
                            data['content'], data['approved'])

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
            """, ( id, ))

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
