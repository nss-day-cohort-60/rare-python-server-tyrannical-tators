class Comment():
    """Class initializer to create comment objects"""
    def __init__(self, id, post_id, author_id, content):
        self.id = id
        self.post_id = post_id
        self.author_id = author_id
        self.content = content
        self.user = None
