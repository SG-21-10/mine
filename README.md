# E-Commerce Flutter App

A complete Flutter e-commerce application with user authentication, product management, and an integrated price calculator.

## 🚀 Features

### 1. User Authentication
- **Easy Sign Up & Login**: User-friendly registration and login screens
- **Form Validation**: 
  - Valid email validation using email_validator package
  - Strong password requirements (minimum 6 characters, uppercase, lowercase, and numbers)
  - Name validation with proper formatting
  - Password confirmation matching
- **Persistent Login**: Users stay logged in using SharedPreferences
- **Demo Credentials**: Pre-configured test accounts for easy testing

### 2. Product Management
- **Product Listing**: Grid view of all available products
- **Search Functionality**: Real-time search by product name, description, and tags
- **Category Filtering**: Filter products by categories (Electronics, Office, Kitchen, Sports, etc.)
- **Price Range Filtering**: Slider-based price range selection
- **Product Details**: Comprehensive product information including:
  - Product images (with placeholder support)
  - Price and ratings
  - Stock availability
  - Category and tags
  - Detailed descriptions

### 3. Advanced Price Calculator
Each product detail page includes a sophisticated calculator with:
- **Quantity Selection**: Input field with validation (1-999 items)
- **Discount Application**: Percentage-based discount (0-100%)
- **Tax Calculation**: Configurable tax percentage
- **Real-time Updates**: Instant calculation updates as values change
- **Detailed Breakdown**: Shows:
  - Price per item
  - Quantity
  - Subtotal
  - Discount amount (if applicable)
  - After-discount price
  - Tax amount (if applicable)
  - **Final Total**
- **Stock Validation**: Prevents ordering more items than available
- **Form Validation**: Ensures all inputs are valid numbers within acceptable ranges

## 📱 Demo Credentials

For testing the application, use these pre-configured accounts:

```
Email: admin@example.com
Password: admin123

Email: user@example.com  
Password: user123
```

## 🏗️ Project Structure

```
lib/
├── main.dart                          # App entry point with providers setup
├── models/                           # Data models
│   ├── user.dart                     # User model
│   └── product.dart                  # Product model
├── providers/                        # State management
│   ├── auth_provider.dart            # Authentication state
│   └── product_provider.dart         # Product data & filtering
├── services/                         # Data services
│   ├── auth_service.dart             # Authentication logic
│   └── product_service.dart          # Product data service
├── screens/                          # App screens
│   ├── auth/
│   │   ├── login_screen.dart         # Login interface
│   │   └── register_screen.dart      # Registration interface
│   ├── home/
│   │   └── home_screen.dart          # Main product listing
│   └── product/
│       └── product_detail_screen.dart # Product details & calculator
├── widgets/                          # Reusable components
│   ├── product_card.dart             # Product grid item
│   ├── search_filter_bar.dart        # Search & filter interface
│   └── price_calculator.dart         # Interactive price calculator
└── utils/
    └── validators.dart               # Form validation functions
```

## 🛠️ Technologies Used

- **Flutter SDK**: Cross-platform mobile development framework
- **Provider**: State management for reactive UI updates
- **SharedPreferences**: Local data persistence for user sessions
- **Email Validator**: Email format validation
- **HTTP**: Network requests (prepared for API integration)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5              # State management
  shared_preferences: ^2.2.2    # Local storage
  email_validator: ^2.1.17      # Email validation
  http: ^0.13.6                 # HTTP requests
  cupertino_icons: ^1.0.2       # iOS icons
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone or extract the project**
   ```bash
   # If you have the project files, navigate to the directory
   cd ecommerce_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For development
   flutter run
   
   # For release
   flutter run --release
   ```

## 🔧 Configuration

### Mock Data
The app uses mock data for demonstration purposes:
- **Products**: 10 sample products across different categories
- **Users**: 2 pre-configured test accounts
- **Authentication**: Simulated login/registration with local storage

### Customization
To modify the app for your needs:

1. **Products**: Edit `lib/services/product_service.dart` to add/modify products
2. **Styling**: Update theme in `lib/main.dart`
3. **Validation**: Modify rules in `lib/utils/validators.dart`
4. **API Integration**: Replace mock services with actual API calls

## 🎯 Key Features Demonstrated

### Form Validation
- Email format validation
- Password strength requirements
- Real-time validation feedback
- Input sanitization and error handling

### Real-time Calculations
- Dynamic price calculations
- Percentage-based discounts and taxes
- Input validation with user feedback
- Stock availability checking

### State Management
- Provider pattern for reactive UI
- Persistent user sessions
- Real-time search and filtering
- Optimized rebuilds for performance

### User Experience
- Intuitive navigation
- Loading states and error handling
- Responsive grid layouts
- Smooth animations and transitions

## 🧪 Testing

The app includes:
- Input validation testing
- Authentication flow testing
- Calculator accuracy testing
- State management testing

## 🔮 Future Enhancements

Potential improvements for production use:
- Backend API integration
- Real payment processing
- Shopping cart functionality
- Order history and tracking
- Push notifications
- Image upload capabilities
- Advanced search filters
- User reviews and ratings

## 📄 License

This project is created for educational and demonstration purposes.

## 🤝 Contributing

Feel free to fork this project and submit pull requests for improvements.

---

**Note**: This is a demonstration app with mock data. For production use, integrate with a real backend API and implement proper security measures.
