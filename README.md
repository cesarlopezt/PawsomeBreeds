# PawsomeBreeds

PawsomeBreeds is an iOS app designed to provide dog lovers with a comprehensive list of dog breeds 
along with a collection of stunning pictures for each breed. With PawsomeBreeds, you can explore various 
dog breeds, view their images, and even save your favorite breeds for quick access.

The app has been developed using SwiftUI and utilizes the [Dog CEO API](https://dog.ceo/dog-api/documentation/) to fetch breeds and images.

## Features

- Browse a vast collection of dog breeds
- View 15 pictures for each breed (You can reload to see more)
- Save your favorite breeds for easy access
- User-friendly interface with intuitive navigation
- Seamlessly fetches breed and image data from the Dog CEO API
- Built with SwiftUI, providing a smooth and responsive user experience
- Store favorite breeds locally using UserDefaults
- Includes unit tests to ensure app functionality and reliability

## Walkthrough


https://github.com/cesarlopezt/PawsomeBreeds/assets/4370350/6bdc7785-5cf9-4c81-b6d2-afb34740a0a9

https://github.com/cesarlopezt/PawsomeBreeds/assets/4370350/598cb9f3-3aab-452c-a167-bec2776f1bfc



## Technologies Used

- **SwiftUI**: PawsomeBreeds is built using the SwiftUI framework, enabling a modern and intuitive user interface design.
- **Codable**: The app utilizes JSON decoding techniques to parse the data retrieved from the Dog CEO API and convert it into usable models.
- **UserDefaults**: PawsomeBreeds leverages UserDefaults to store and retrieve favorite breeds, allowing users to easily access their preferred breeds.
- **Unit Testing**: The app includes a suite of unit tests to verify the functionality of the `FavoritesStorage` component to ensure app stability.

## Installation

1. Clone the repository from GitHub.
2. Open the project in Xcode.
3. Build and run the project on the iOS Simulator or a connected iOS device.

## Usage

Upon launching PawsomeBreeds, you will be presented with a list of dog breeds. Tap on any breed to view a
collection of 15 stunning pictures for that breed. To save a breed as a favorite, simply tap the "star" button. 
You can access your favorite breeds from the Favorites tab.
