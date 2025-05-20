# GitHub App

## Purpose

A mobile application that allows users to search for GitHub profiles, view user information, browse followers, and save favorite users for quick access.

## Features Demonstration

Below are demonstrations of key app features:

| Feature                 | Demonstration                                                                                                           |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **User Search**         | ![Searching for GitHub users](./GIF/user-search.gif)<br>_Searching for users by GitHub username_                        |
| **User Profile**        | ![Viewing user profile details](./GIF/user-profile.gif)<br>_Viewing detailed information about a GitHub user_           |
| **Followers List**      | ![Browsing user followers](./GIF/followers-list.gif)<br>_Browsing through a user's followers_                           |
| **Searching Followers** | ![Searching within followers](./GIF/search-followers.gif)<br>_Filtering a user's followers list_                        |
| **Favorites**           | ![Accessing favorites tab](./GIF/favorites-tab.gif)<br>_Accessing your saved favorite GitHub users_                     |
| **Adding to Favorites** | ![Adding users to favorites](./GIF/add-to-favorites.gif)<br>_Adding GitHub users to your favorites list_                |
| **Error Handling**      | ![Error handling demonstration](./GIF/error-handling.gif)<br>_How the app handles errors and edge cases_                |
| **Empty States**        | ![Empty states display](./GIF/empty-states.gif)<br>_How the app displays empty states (no results, no favorites, etc.)_ |

## Technologies

- **Swift 5**
- **UIKit**
- **Programmatic UI** (no storyboards)
- **AutoLayout**
- **URLSession** for network requests
- **UserDefaults** for persisting favorite users
- **Codable** for JSON parsing
- **GitHub REST API**

## Architecture

- **Project Structure**: Features (Search, Followers, User, Favorites), Services, Model, Utilities, Common
- **Design Patterns**: MVC with separation of views and controllers, Delegate, Protocol-Oriented Programming, Dependency Injection
- **UI Implementation**: Custom components, UICollectionView, UITableView, Generic View Controller, UIView extension

## Requirements

- iOS 15.0+
- Xcode 12.0+
- Swift 5.0+
