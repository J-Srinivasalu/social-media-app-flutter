# Social Media App - Flutter Mobile App

This Flutter mobile app is part of the Social Media App project, which aims to replicate the basic functionality of a social media platform. The app utilizes the backend created with Node.js, Express, and MongoDB.

## Overview

The mobile app allows users to interact with the social media platform on the go. It provides a user-friendly interface for accessing and contributing to posts, comments, and more.

## Features

1. **User Authentication:**

   - Login and register functionalities.

2. **Upload Posts:**

   - Users can upload posts with text and images.

3. **Get All Posts:**

   - Access a feed showing all posts.

4. **View Others' Profiles:**

   - Explore other users' profiles and view their posts.

5. **Comments:**

   - Add comments on posts.

6. **Like Posts and Comments:**
   - Users can like both posts and comments.

## Screens

1. **Login:**

   - User login screen.

2. **Register:**

   - User registration screen.

3. **Main Navigation:**

   - Bottom navigation bar with the following tabs:

     - **Home:** Displays all posts.
     - **Profile:** Shows the user's profile.
       - **Logout:** Log out of the app.
       - **Update Profile:** Modify user profile.

   - **Upload Post:**
     - Allows users to create and upload posts.

4. **Public Profile:**

   - Displays a user's public profile with sections for user details and their posts.

5. **Single Post View:**
   - Detailed view of a single post, including comments.

## Future Plans

1. **Upload Gifs, Videos, and PDFs:**

   - Enhance post content options.

2. **Friend Requests:**

   - Send/receive friend requests.

3. **Privacy Settings:**

   - Make posts visible only to friends.

4. **Notifications:**

   - Receive notifications when friends upload a post.

5. **Real-time Chat:**
   - Enable real-time chat with friends.

## Getting Started

To run the Flutter mobile app, follow these steps:

1. Clone this repository.
2. Run the following commands:

```bash
flutter pub get
flutter run --flavor dev -t lib/main_dev.dart
```

## Screeshots

|        Login Screen         |        Register Screen         |   Main Navigations(Home)   |   Main Navigations(Profile)   |
| :-------------------------: | :----------------------------: | :------------------------: | :---------------------------: |
| <img src="screenshots/login.jpeg" alt="Login Screen" width="200"/> | <img src="screenshots/register.jpeg" alt="Register Screen" width="200"/> | <img src="screenshots/home.jpeg" alt="Home Screen" width="200"/> | <img src="screenshots/profile.jpeg" alt="Profile Screen" width="200"/> |

|        Post Screen         |        Public Profile Screen         |        Create Post Screen         |        Create Post section         |
| :------------------------: | :----------------------------------: | :-------------------------------: | :--------------------------------: |
| <img src="screenshots/post.jpeg" alt="Post Screen" width="200"/> | <img src="screenshots/public_profile.jpeg" alt="Public profile Screen" width="200"/> | <img src="screenshots/create_post.jpeg" alt="Create Post Screen" width="200"/> | <img src="screenshots/select_image.jpeg" alt="Select Image Screen" width="200"/> |

|        Edit profile Screen         |
| :--------------------------------: |
| <img src="screenshots/edit_profile.jpeg" alt="Edit Profile Screen" width="200"/> |

Feel free to reach out for any questions or feedback. Happy coding!
