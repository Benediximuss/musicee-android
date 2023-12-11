# CS 308 Term Project - Musicee (Android)

## Project Overview

This project aims to develop an online system for collecting liked-song information from various sources and providing users with analyses and recommendations based on their musical preferences. 
The system focuses on user interaction and personalized music choice analysis without involving music streaming.

### ALL Functionalities

### Data Format

- **Basic Data Format:**
  
  - Collects song information, including track name, performer(s), album/media details, and user ratings.
  - Handles challenges like multiple performers and different versions of the same song.

### Data Collection

- **User Input:**
  - Allows manual song input through a user-friendly web/mobile interface.
  - Supports batch input via file uploads (.json).
  - Permits data transfer from a self-hosted or cloud database.
  - Enables users to rate non-rated songs/albums/performers and modify ratings over time.

### Analysis of Musical Choices

- **Statistical Information:**
  - Provides users with statistical insights into their preferences, filterable by date constraints.
- **Tables and Charts:**
  - Displays tables showing how many likes the singers' songs received over time.

### Recommendations

- **Music Recommendations:**
  - Suggests songs based on user ratings.
  - Considers temporal properties and recommends less active but highly-rated items.
  - Recommends based on friendship activity.

### Additional Features

- **Authentication:**
  - Supports password-based authentication.
- **Friends and Friendship:**
  - Enables users to add friends.
- **Result Sharing:**
  - Permits sharing analysis results on social media platforms.
- **Data Exporting:**
  - Facilitates exporting song ratings with filtering options.

## Installation

Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.

1. Clone the repository:

    ```bash
    git clone https://github.com/Benediximuss/musicee-android.git
    ```

2. Navigate to the project directory:

    ```bash
    cd musicee-android
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

Ensure you have an Android emulator or a connected device.

```bash
flutter run
```
