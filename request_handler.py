from http.server import BaseHTTPRequestHandler, HTTPServer
import json
from urllib.parse import urlparse, parse_qs
from views.user import create_user, login_user
from views import (all, single, edit_all, delete_all, get_comments_by_post, create, get_subscriptions_by_userId)

method_mapper = {
    'single': single, 'all': all
}

class HandleRequests(BaseHTTPRequestHandler):
    """Handles the requests to this server"""

    def get_all_or_single(self, resource, id, key, value):
        """Determines whether the client needs all items or a single item and then calls the correct function."""

        if id is not None:
            response = method_mapper["single"](resource, id)

            if response is None:
                self._set_headers(404)
                response = ''
            else:
                self._set_headers(200)
        else:
            response = method_mapper["all"](resource, key, value)

            if response is not None:
                self._set_headers(200)
            else:
                self._set_headers(404)
                response = ''

        return response

    def parse_url(self, path):
        """Parse the url into the resource and id"""
        path_params = self.path.split('/')
        resource = path_params[1]
        id = None
        key=None
        value = None
        if '?' in resource:
            param = resource.split('?')[1]
            resource = resource.split('?')[0]
            pair = param.split('=')
            key = pair[0]
            value = pair[1]
            return (resource, id, key, value)
        else:
            
            try:
                id = int(path_params[2])
            except (IndexError, ValueError):
                pass
            return (resource, id, key, value)

    def _set_headers(self, status):
        """Sets the status code, Content-Type and Access-Control-Allow-Origin
        headers on the response

        Args:
            status (number): the status code to return to the front end
        """
        self.send_response(status)
        self.send_header('Content-type', 'application/json')
        self.send_header('Access-Control-Allow-Origin', '*')
        self.end_headers()

    def do_OPTIONS(self):
        """Sets the OPTIONS headers
        """
        self.send_response(200)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods',
                        'GET, POST, PUT, DELETE')
        self.send_header('Access-Control-Allow-Headers',
                        'X-Requested-With, Content-Type, Accept')
        self.end_headers()

    def do_GET(self):
        """Handles GET requests to the server"""
        # Parse URL and store entire tuple in a variable
        parsed = self.parse_url(self.path)
        if '?' not in self.path:
            response = None
            (resource, id, key, value) = parsed
            response = self.get_all_or_single(resource, id, key, value)

        else: # There is a ? in the path, run the query param functions
            
            response = {}
            (resource, id, key, value) = parsed
            if key == 'post_id' and resource == 'comments':
                self._set_headers(200)
                response = get_comments_by_post(value)
            elif key == 'follower_id' and resource == 'posts':
                self._set_headers(200)
                response = get_subscriptions_by_userId(value)
            else:
                response = self.get_all_or_single(resource, id, key, value)


        self.wfile.write(json.dumps(response).encode())


    def do_POST(self):
        """Make a post request to the server"""
        self._set_headers(201)
        content_len = int(self.headers.get('content-length', 0))
        post_body = json.loads(self.rfile.read(content_len))
        response = ''
        (resource, id, key, value) = self.parse_url(self.path)

        if resource == 'login':
            response = login_user(post_body)
        elif resource == 'register':
            response = create_user(post_body)
        else:
            response = create(resource, post_body)

        self.wfile.write(response.encode())

    def do_PUT(self):
        """Handles PUT requests to the server"""
        content_len = int(self.headers.get('content-length', 0))
        post_body = self.rfile.read(content_len)
        post_body = json.loads(post_body)

        # Parse the URL
        (resource, id, key , value) = self.parse_url(self.path)

        success = False
        success = edit_all(resource, id, post_body)

        if success:
            self._set_headers(204)
        else:
            self._set_headers(404)

        # Encode the new object and send in response
        self.wfile.write("".encode())

    def do_DELETE(self):
        """Handle DELETE Requests"""
        (resource, id, key , value) = self.parse_url(self.path)
        message = ""
        self._set_headers(204)
        delete_all(resource, id)
        self.wfile.write(message.encode())

def main():
    """Starts the server on port 8088 using the HandleRequests class
    """
    host = ''
    port = 8088
    HTTPServer((host, port), HandleRequests).serve_forever()


if __name__ == "__main__":
    main()
