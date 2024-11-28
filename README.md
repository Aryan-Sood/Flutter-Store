# Flutter Store

Assignment submission for Neura Dynamics

## Getting Started

This app allows to browse through various items available through the store.

This app features:
- Home Page
- Description Modal

## Functionality
- When you click on an image, it opens its description modal with all the necessary details about the item selected.
- Used carousels to display multiple images.
- Implemented the state management through Provider, the data called through API is stored and reused.
- I have used cached network image package to reduce the times loading of same images occurs at different views.
- I am also working on sorting the products based on the category id (in progress).

## Technical aspects
The whole project is divided into various folders:
- Constants -> Universal content used over the pages.
- Models -> Contain the Product and Category Model for API data conversion.
- Services -> Includes the service of calling the API endpoint for data.
- Utils -> Used for local services like converting API data to the corresponding models.
- Views - > Contains code for the home page and the modal sheet (description page).
- Widgets -> Contains the commonly used widgets across the app.

## Issues before
Initially, there were some issues with the links of some of the images of the products.
I initially wrote the code for extracting the correct URL if valid else use a default link.
The code is present in src/utils/productconverter.dart but its commented out since now all links work fine.

