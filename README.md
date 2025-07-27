# E-Commerce Flutter App

A complete Flutter e-commerce application with user authentication, product browsing, search/filter functionality, and an integrated price calculator.

## Features

### 1. User Authentication
- **Sign Up**: Create new accounts with email validation and strong password requirements
- **Login**: Secure login with email and password
- **Form Validation**: Real-time validation for all input fields
- **Password Requirements**: Must be at least 8 characters with uppercase, lowercase, and numbers
- **Session Management**: Users stay logged in using SharedPreferences

### 2. Product Display
- **Product Grid**: Clean grid layout showing product cards
- **Product Details**: Detailed view with images, descriptions, and pricing
- **Stock Status**: Visual indicators for in-stock and out-of-stock items
- **Categories**: Products organized by categories (Electronics, Footwear, Clothing, Accessories)

### 3. Search and Filter
- **Search Bar**: Real-time search by product name or description
- **Category Filter**: Filter products by category using chip-based selection
- **Combined Filtering**: Search and category filters work together

### 4. Price Calculator
- **Quantity Selection**: Users can specify how many items they want
- **Discount Application**: Apply percentage-based discounts
- **Tax Calculation**: Add tax percentage to the final price
- **Real-time Updates**: Calculations update immediately as users change values
- **Detailed Breakdown**: Shows subtotal, discount amount, tax amount, and final total

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── user.dart            # User data model
│   └── product.dart         # Product data model
├── providers/
│   ├── auth_provider.dart   # Authentication state management
│   └── product_provider.dart # Product state and filtering
├── services/
│   ├── auth_service.dart    # Authentication logic
│   └── product_service.dart # Product data service
├── screens/
│   ├── splash_screen.dart   # Initial loading screen
│   ├── auth/
│   │   ├── login_screen.dart    # User login
│   │   └── signup_screen.dart   # User registration
│   ├── home/
│   │   └── home_screen.dart     # Main product listing
│   └── product/
│       └── product_detail_screen.dart # Product details with calculator
├── widgets/
│   ├── custom_text_field.dart   # Reusable input field
│   ├── loading_button.dart      # Button with loading state
│   ├── product_card.dart        # Product grid item
│   ├── search_bar.dart          # Search functionality
│   ├── category_filter.dart     # Category selection
│   └── price_calculator.dart    # Interactive price calculator
└── utils/
    ├── validators.dart          # Input validation functions
    └── app_theme.dart          # App theming and colors
```

## Key Components

### Authentication System
- Mock authentication with in-memory storage
- Email validation using email_validator package
- Password strength validation
- Persistent login state with SharedPreferences

### Product Management
- Mock product data with 10 sample products
- Categories: Electronics, Footwear, Clothing, Accessories
- Search functionality across name and description
- Real-time filtering and sorting

### Price Calculator Features
- **Quantity Input**: Numeric input with validation (minimum 1)
- **Discount Field**: Percentage input (0-100%)
- **Tax Field**: Percentage input (any positive value)
- **Calculation Display**:
  - Price per item
  - Quantity selected
  - Subtotal (price × quantity)
  - Discount amount (if applicable)
  - Amount after discount
  - Tax amount (if applicable)
  - Final total
- **Input Validation**: Prevents invalid entries and auto-corrects out-of-range values

## Design Features

### UI/UX
- Material Design components
- Consistent color scheme with blue primary color
- Responsive grid layout for products
- Card-based design for clean presentation
- Loading states and error handling
- Pull-to-refresh functionality

### Form Validation
- Real-time validation feedback
- Clear error messages
- Visual indicators for field states
- Prevention of invalid submissions

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5              # State management
  shared_preferences: ^2.2.2    # Local storage
  email_validator: ^2.1.17      # Email validation
  http: ^0.13.6                 # HTTP requests (for future API integration)
  cupertino_icons: ^1.0.2       # iOS-style icons
```

## Getting Started

1. **Prerequisites**:
   - Flutter SDK (3.0.0 or higher)
   - Dart SDK
   - Android Studio or VS Code with Flutter extensions

2. **Installation**:
   ```bash
   # Clone or download the project
   cd ecommerce_app
   
   # Get dependencies
   flutter pub get
   
   # Run the app
   flutter run
   ```

3. **Testing the App**:
   - Create a new account with a valid email and strong password
   - Browse products using search and category filters
   - Tap on any product to view details
   - Use the price calculator to calculate totals with different quantities, discounts, and taxes

## Sample Products

The app includes 10 mock products across different categories:
- **Electronics**: iPhone 15 Pro, MacBook Air M2, Sony Headphones, iPad Pro, Galaxy Watch
- **Footwear**: Nike Air Max 270, Adidas Ultraboost 22
- **Clothing**: Levi's 501 Jeans, North Face Jacket
- **Accessories**: Ray-Ban Aviator

## Future Enhancements

- Real API integration
- Shopping cart functionality
- Payment processing
- User profiles and order history
- Product reviews and ratings
- Push notifications
- Offline support

## Technical Notes

- Uses Provider pattern for state management
- Mock data services for demonstration
- Responsive design for different screen sizes
- Proper error handling and loading states
- Clean architecture with separation of concerns
