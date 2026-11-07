# Resto QR - Restaurant Menu & Analytics Platform

A comprehensive Flutter application for restaurant owners and managers to create, manage, and analyze digital menus through QR code technology. Built with Supabase backend, the app provides real-time analytics, item management, promotional offers, and multi-language support.

## 🌟 Features

### Authentication & User Management

- **Email/OTP Verification** - Secure multi-factor authentication with OTP verification codes
- **Sign-up Flow** - Two-step registration with account info and business info
- **Profile Management** - Update restaurant profile, logo, name, and business details
- **Password Management** - Secure password change and forgot password recovery
- **Persistent Login** - Hydrated state management maintains session between app launches

### Menu & Item Management

- **Digital Menu System** - Create and manage restaurant menus with full customization
- **Category Management** - Organize menu items into categories with:
  - Visibility toggles (show/hide categories)
  - Item count tracking
  - Category images
  - Hierarchical organization
- **Menu Item Operations** - Add, edit, and delete items with:
  - Multiple image uploads per item
  - Flexible pricing with discount support
  - Detailed descriptions
  - Real-time view count tracking
  - Expiration date scheduling
  - Visibility controls
- **Menu Themes** - Customize menu appearance per restaurant:
  - Primary and background colors
  - Card styling (radius, elevation)
  - Font family selection (Roboto, Lato, Open Sans)
  - Theme persistence across sessions

### Offers & Promotions

- **Promotional Banners** - Create eye-catching promotional content:
  - Custom banner images with upload
  - Redirect URL configuration for marketing
  - Interaction tracking and analytics
  - Scheduled expiration dates
  - Live/draft status management
  - Banner performance metrics
- **Item Discounts** - Apply percentage-based discounts with:
  - Discount percentage configuration
  - Expiration date support
  - Automatic discount removal at expiry
  - Discount visibility in menu
- **Offer Control** - Dedicated management for promotions:
  - Add/edit/remove offers
  - Batch discount management
  - Offer scheduling

### Analytics Dashboard

- **Real-time Statistics** - Monitor menu performance with:
  - Total menu views and trends
  - Individual item view counts
  - Banner interaction analytics
  - Most viewed items ranking (top 5)
  - Visitor engagement metrics
- **Custom Date Range Analytics** - Analyze performance for specific periods
- **Metrics Tracking** - Monitor:
  - Menu visit events
  - Item view events
  - Banner interaction events
  - Customer engagement patterns
- **Statistics Export** - View and share analytics data

### Localization & Multi-Language Support

- **Full i18n Implementation** - Complete internationalization using intl and intl_utils packages
- **Multi-Language Support** - Localized strings for all UI elements
- **Dynamic Language Switching** - Change language in-app without restart
- **Language Model** - Support for multiple language configurations

### Maps & Location Services

- **Mapbox Integration** - Interactive map visualization with:
  - Restaurant location display
  - Custom map styling (light/dark themes)
  - Map controls and interaction
- **Geolocation Services** - Location-based features:
  - GPS coordinate tracking
  - Location permissions management
  - Address-based restaurant identification
- **Location Service** - Dedicated service for:
  - Fetching current location
  - Storing restaurant coordinates
  - Location-based filtering

### QR Code Features

- **Dynamic QR Code Generation** - Create QR codes for:
  - Menu sharing
  - Item promotions
  - Direct access links
- **QR Code Management** - Dedicated Cubit for:
  - QR generation logic
  - QR state management
  - QR code caching
- **Menu Sharing** - Share menus via QR codes with customers

### Media Management

- **Image Picker** - Seamless image upload from:
  - Device camera (real-time capture)
  - Photo gallery
  - Multiple image selection
- **Batch Image Upload** - Support multiple images:
  - Multiple files per menu item
  - Concurrent upload management
- **Image Compression** - Automatic optimization:
  - Reduce file size before upload
  - Maintain image quality
  - Faster upload speeds
- **Cached Image Loading** - Performance features:
  - Network image caching
  - Offline image access
  - Loading placeholders
- **Gallery Integration** - Save and manage images:
  - Save to device gallery
  - Gallery service layer
  - Image organization

### PDF & Printing Features

- **PDF Generation** - Create documents for:
  - Menu exports
  - Receipt generation
  - Report compilation
- **Print Support** - Direct printing:
  - AirPrint integration
  - Print preview
  - Layout customization
- **Document Export** - Share generated files

### User Experience

- **Onboarding Flow** - Guided setup for new users:
  - Welcome screens
  - Account creation
  - Business information
  - Completion confirmation
- **Splash Screen** - Professional app startup
- **Persistent Navigation** - Bottom navigation bar:
  - Home dashboard
  - Menu management
  - Location/Maps
  - Settings
  - Profile
- **Toast Notifications** - User feedback:
  - Success messages
  - Error alerts
  - Information notices
- **Skeleton Loading** - Professional loading states:
  - Animated skeleton placeholders
  - Smooth transitions
  - Better perceived performance
- **Smooth Animations** - Fluid UI transitions:
  - Page navigation
  - Widget state changes
  - Interactive feedback
- **Error Handling** - Graceful error management:
  - Crash prevention
  - User-friendly error messages
  - Error recovery options
- **Maintenance View** - Backend maintenance notifications

### Developer & Admin Features

- **Sentry Integration** - Production monitoring:
  - Real-time crash reporting
  - Error tracking
  - Performance monitoring
  - Stack trace collection
  - Session replay (on PRO)
- **Permission Management** - Runtime permissions:
  - Location permission requests
  - Camera permission handling
  - Storage permission management
  - Permission status tracking
- **App Version Management** - Version tracking:
  - Current version display
  - Build number tracking
  - Package information
- **Hydrated BLoC** - Persistent state:
  - Automatic serialization
  - Session restoration
  - Cache management

### Social & Sharing Features

- **URL Launcher** - URL handling:
  - Open external websites
  - Deep link support
  - Custom URL schemes
- **Share Functionality** - Share menus via:
  - WhatsApp
  - Email
  - Social media
  - Direct messaging
- **Phone Number Validation** - International phone input:
  - Country code support
  - Format validation
  - Number verification

### UI/UX Features

- **Theme Management** - App-wide theming:
  - Dark mode support
  - Light mode
  - Dynamic color switching
  - Theme persistence
- **Color Customization** - Color picker for:
  - Menu theme colors
  - Restaurant branding
  - UI customization
- **Chart Visualization** - Analytics display:
  - Line charts for trends
  - Bar charts for comparisons
  - Pie charts for distributions
  - Legend and tooltips
- **Font Management** - Custom fonts:
  - Lato font family
  - Open Sans font family
  - Roboto font family
  - Font scaling

## 📊 Database Schema

The app uses Supabase with the following main tables:

### Core Tables

- **users** - User profiles with phone and email
- **restaurants** - Restaurant information and ownership
- **menus** - Digital menu per restaurant with view counts
- **menu_theme** - Customizable theme settings per menu

### Menu Structure

- **categories** - Menu categories with visibility controls
- **menu_items** - Individual menu items with pricing and images
- **banners** - Promotional banners with tracking

### Analytics & Events

- **events** - Tracks menu visits, item views, banner interactions
- **otp_codes** - OTP verification for authentication

### Key RPC Functions

The backend provides serverless functions for:

- `get_categories` - Fetch visible categories
- `get_items` - Get items by category
- `get_all_standard_stats` - Dashboard statistics
- `get_custom_dashboard_stats` - Date-range analytics
- `increment_menu_view_count` - Track menu views
- `increment_view_count` - Track item views
- `log_event` - Log user interactions
- `add_item`, `update_item` - Item management
- `add_category`, `update_category` - Category management
- `add_banner`, `update_banner` - Banner management
- `update_profile` - Profile updates
- `user_login` - Authentication

See [ai/db.md](ai/db.md) for complete database documentation.

## 🏗️ Project Architecture

### Feature-Based Structure

```
lib/
├── Feature/
│   ├── Auth/                          # Authentication
│   │   ├── Helper/                    # OTP timer, form validation
│   │   ├── Model/                     # Auth models
│   │   ├── Repo/                      # Auth repositories (login, signup, OTP, password)
│   │   ├── View Model/                # BLoC/Cubits (login, signup, OTP, forgot password)
│   │   ├── Views/                     # UI screens
│   │   └── Widgets/                   # Reusable auth widgets
│   │
│   ├── Home/                          # Main dashboard & menu management
│   │   ├── Dialogs/                   # Modals (add discount, ingredients, offers)
│   │   ├── Models/                    # Data models (item, category, theme, stats)
│   │   ├── Repo/                      # Repositories
│   │   │   ├── category_repo.dart     # Category CRUD
│   │   │   ├── items_repo.dart        # Item CRUD
│   │   │   ├── home_repo.dart         # Dashboard & statistics
│   │   │   ├── offers_repo.dart       # Promotional offers
│   │   │   └── profile_settings_repo  # Profile management
│   │   ├── View Model/                # State management
│   │   │   ├── category_cubit         # Category state
│   │   │   ├── item_cubit             # Item state
│   │   │   ├── home_cubit             # Dashboard state
│   │   │   ├── qr_code_cubit          # QR code generation
│   │   │   ├── top_items_cubit        # Top items analytics
│   │   │   ├── offer_cubit            # Offers state
│   │   │   └── profile_cubit          # Profile state
│   │   ├── Views/                     # Dashboard screens
│   │   └── Widgets/                   # Reusable components
│   │
│   ├── Maps/                          # Location & mapping
│   │   ├── Model/                     # Location models
│   │   ├── Repo/                      # Location repository
│   │   ├── Service/                   # Location services
│   │   ├── View Model/                # Maps state management
│   │   ├── Views/                     # Map screens
│   │   └── Widgets/                   # Map components
│   │
│   ├── Onboarding/                    # User setup flow
│   │   ├── Views/                     # Onboarding screens
│   │   ├── Widgets/                   # Onboarding components
│   │   └── View Model/                # Onboarding state
│   │
│   ├── Splash/                        # App startup
│   │   └── Views/                     # Splash screen
│   │
│   └── Website/                       # Web-related features
│       ├── Banners/                   # Banner management
│       └── Views/                     # Web views
│
├── Core/                              # Shared code
│   ├── Base State/                    # Common state classes
│   ├── Cubit/                         # Global app state (app_cubit)
│   ├── Dialogs/                       # Common dialogs
│   ├── Models/                        # Shared models & exceptions
│   ├── Services/                      # Core services
│   │   ├── supabase_db.dart          # Database queries
│   │   ├── supabase_rpc.dart         # RPC function calls
│   │   ├── supabase_function.dart    # Cloud functions
│   │   ├── image_service.dart        # Image upload/management
│   │   └── gallery_service.dart      # Gallery access
│   ├── Utils/                         # Utilities
│   │   ├── app_localization.dart     # i18n setup
│   │   ├── app_permissions.dart      # Permission handling
│   │   ├── app_theme.dart            # Theme configuration
│   │   ├── image_compress.dart       # Image optimization
│   │   └── stream_wrapper.dart       # Stream utilities
│   ├── Views/                         # Shared screens
│   │   ├── app_crash_view.dart       # Error handling
│   │   └── maintenance_view.dart     # Maintenance notifications
│   └── Widgets/                       # Reusable widgets
│
├── generated/                         # Auto-generated files
├── l10n/                              # Localization files
└── main.dart                          # App entry point
```

### State Management Pattern

- **BLoC Pattern** - Business Logic Component for clean architecture
- **Cubits** - Simplified version of BLoC for simple state changes
- **Hydrated BLoC** - Persistent state that survives app restarts
- **Repository Pattern** - Data layer abstraction

### Service Layer

- **SupabaseDb** - Direct database queries and updates
- **SupabaseRpc** - Call serverless functions
- **SupabaseFunction** - Cloud function execution
- **ImageService** - Handle image uploads and optimization
- **GalleryService** - Access device gallery

## 🔧 Technology Stack

### Core Framework

- **Flutter** 3.11.0+ - Cross-platform UI framework
- **Dart** - Programming language

### State Management

- **Flutter BLoC** 9.1.1 - State management pattern
- **Hydrated BLoC** 11.0.0 - Persistent state storage

### Backend & Services

- **Supabase Flutter** 2.12.0 - Backend as a Service
  - PostgreSQL database
  - Real-time capabilities
  - Serverless RPC functions
- **Sentry Flutter** 9.27.0 - Error tracking & monitoring

### Maps & Location

- **Mapbox Maps Flutter** 2.29.0 - Interactive mapping
- **Geolocator** 14.0.2 - GPS location services
- **Flutter Intl Phone Field** 0.0.7 - Phone number input

### Media & Image

- **Image Picker** 1.2.1 - Camera and gallery access
- **Flutter Image Compress** 2.4.0 - Image optimization
- **Cached Network Image** 3.4.1 - Image caching
- **Gal** 2.3.2 - Gallery integration

### Document Generation

- **PDF** 3.11.3 - PDF creation
- **Printing** 5.14.2 - Print and PDF export
- **QR Flutter** 4.1.0 - QR code generation

### Localization

- **Intl** 0.20.2 - Internationalization
- **Intl Utils** 2.8.14 - i18n utilities
- **Flutter Localizations** - Material localization

### UI Components

- **Flutter SVG** 2.2.4 - SVG rendering
- **Flutter Animate** 4.5.2 - Animation library
- **Smooth Page Indicator** 2.0.1 - Page indicators
- **Loading Animation Widget** 1.3.0 - Loading animations
- **Skeletonizer** 2.1.2 - Skeleton loaders
- **FL Chart** 1.1.1 - Charts and graphs
- **Flutter ColorPicker** 1.1.0 - Color selection
- **Font Awesome Flutter** 11.0.0 - Icon library
- **Cupertino Icons** 1.0.8 - iOS icons
- **Persistent Bottom Nav Bar** 6.2.1 - Custom navigation
- **Pinput** 6.0.1 - PIN/OTP input
- **Toastification** 3.0.3 - Toast notifications

### Utilities

- **Dartz** 0.10.1 - Functional programming (Either/Result pattern)
- **Path Provider** 2.1.5 - File system access
- **Package Info Plus** 10.2.1 - App version info
- **URL Launcher** 6.3.2 - URL handling
- **Share Plus** 13.3.0 - Share functionality
- **Permission Handler** 13.0.0 - Permission management
- **HTTP** 1.6.0 - HTTP requests
- **Flutter Toast** 10.0.0 - Toast notifications (legacy)

### Native Features

- **Flutter Native Splash** 2.4.8 - Splash screen configuration

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.11.0 or higher
- Dart SDK
- iOS 11.0+ (for iOS development)
- Android API 21+ (for Android development)
- Xcode (for iOS)
- Android Studio (for Android)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd resto_qr
   ```

2. **Install Flutter dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate localization files**

   ```bash
   flutter pub run intl_utils:generate
   ```

4. **Run the app**

   ```bash
   # iOS
   flutter run -d ios
   
   # Android
   flutter run -d android
   
   # Web
   flutter run -d web
   ```

## 🛠️ Development Commands

### Common Commands

- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Update dependencies
- `flutter pub run intl_utils:generate` - Generate localization files
- `flutter analyze` - Run dart analyzer
- `flutter analyze lib/Feature/Home` - Analyze specific feature
- `flutter run` - Run app on connected device
- `flutter run --release` - Release build
- `flutter build apk` - Build Android APK
- `flutter build appbundle` - Build Android App Bundle
- `flutter build ios` - Build iOS app

### Available Tasks

- **Generate localization** - Regenerate i18n files after adding translations
- **Analyze Home** - Lint the Home feature module

## 🔐 Configuration

### Supabase Setup

The app connects to Supabase for all backend operations:

```dart
// Configured in main.dart
await Supabase.initialize(
  publishableKey: 'YOUR_PUBLISHABLE_KEY',
  url: 'YOUR_SUPABASE_URL',
);
```

### Sentry Configuration

Error tracking is configured for production monitoring:

```dart
await SentryFlutter.init(
  (options) {
    options.dsn = 'YOUR_SENTRY_DSN';
  },
);
```

### Mapbox Configuration

Map styling uses custom map styles stored in `assets/map_styles/`:

- `light_map_style.json` - Light theme map
- `dark_map_style.json` - Dark theme map

### Google Maps & Location

Location services require appropriate permissions:

- `android/app/src/main/AndroidManifest.xml` - Android permissions
- `ios/Runner/Info.plist` - iOS permissions

## 🌍 Localization

### Adding New Languages

1. Add translation file to `lib/l10n/intl_xx.arb` (where `xx` is language code)
2. Add strings to match existing keys
3. Run: `flutter pub run intl_utils:generate`
4. Update app language settings

### Supported Features

- Multi-language UI strings
- Date/time localization
- Number formatting
- Currency display

## 🧪 Testing & Quality

### Code Analysis

- Dart analyzer integration
- Custom linting rules in `analysis_options.yaml`
- Feature-level analysis support

### Error Tracking

- Sentry integration for production crashes
- Debug error widget display
- Crash view for error recovery

## 📱 Platform Support

- **iOS** - Full support (11.0+)
- **Android** - Full support (API 21+)

## 🐛 Error Handling & Monitoring

### Error Management

- Custom `AppException` model
- `ExceptionHandler` for error processing
- Crash recovery view
- User-friendly error messages

### Monitoring

- Sentry crash reporting
- Performance monitoring
- Session tracking
- Error categorization

## 📈 Performance Optimization

- **Image Compression** - Automatic before upload
- **Image Caching** - Network image caching
- **Skeleton Loading** - Better perceived performance
- **Hydrated State** - Avoid redundant API calls
- **Stream Management** - Efficient data updates

## 📚 Project Documentation

- [Database Schema & Documentation](ai/db.md) - Complete database design
- [API RPC Functions](ai/db.md#rpc-functions) - Backend function reference
- Database Triggers and automation

## 🔗 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.com/docs)
- [BLoC Pattern Guide](https://bloclibrary.dev/)
- [Mapbox Flutter Plugin](https://pub.dev/packages/mapbox_maps_flutter)
- [Sentry Documentation](https://docs.sentry.io/)

## 📄 License

This project is private and proprietary.

## 👥 Support

For issues, questions, or contributions, please contact the development team.
