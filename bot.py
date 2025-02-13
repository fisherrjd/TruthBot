from truthbrush.api import Api
import os
import json

# Load credentials from environment variables
username = os.getenv("TRUTHSOCIAL_USERNAME")
password = os.getenv("TRUTHSOCIAL_PASSWORD")

# Initialize the Api client
client = Api(username, password)

from itertools import islice

user_posts = client.pull_statuses("realDonaldTrump")  # This returns a generator
for post in islice(user_posts, 5):
    # Extract the relevant information

    filtered_post = {
        "uri": post.get("uri"),
        "username": post.get("username"),
        "content": post.get("content"),
        "media_attachments": post.get("media_attachments"),
    }

    # Print the filtered post as prettified JSON
    print(json.dumps(post, indent=4))
