# Ecommerce App

A mobile ecommerce application built with Flutter.  
This app demonstrates clean architecture, domain-driven design, and unit testing.

## Features

- Product listing (CRUD)
- Product details
- Add, update, and delete products
- Search products
- Local and remote data sources
- Error handling and network awareness

## Architecture

This project follows the principles of **Clean Architecture** to ensure separation of concerns, testability, and scalability.

### Domain Layer

The **Domain Layer** is the core of the application and contains:

- **Entities:** Plain Dart classes that represent the core business objects (e.g., `Product`).
- **Repositories (Abstract):** Contracts that define the operations available for each feature (e.g., `ProductRepository`).  
- **Usecases:** Classes that encapsulate specific business logic or actions (e.g., `AddProductUsecase`, `GetAllProductsUsecase`).  
- **No dependencies on Flutter or external packages.**  
- **Business rules and validation** are handled here to keep the logic independent of UI and data sources.

### Data Layer

The **Data Layer** is responsible for:

- **Models:** Data representations that can be serialized/deserialized (e.g., `ProductModel`).
- **Repository Implementations:** Concrete classes that implement the domain repositories, connecting them to data sources.
- **Data Sources:** Classes that fetch and persist data, either locally (e.g., SQLite, SharedPreferences) or remotely (e.g., REST API).
- **Handles mapping between models and entities.**

### Presentation Layer

The **Presentation Layer** contains:

- **UI Widgets and Screens:**
- **State Management:** ( Bloc) to manage UI state and communicate with usecases.
- **Form validation and user input handling.**

---

### How the Layers Communicate

- The **Presentation Layer** interacts with the **Domain Layer** by calling usecases.
- The **Domain Layer** uses **Repository** contracts to request or persist data.
- The **Data Layer** implements these contracts and communicates with local/remote data sources.
- **Entities** flow from the Data Layer to the Domain Layer, ensuring business logic is always applied.

---

## Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/ecommerce_app.git
   cd ecommerce_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

4. **Run tests:**
   ```bash
   flutter test
   ```

## Folder Structure

```
lib/
  features/
    product/
      domain/
        entities/
        repositories/
        usecases/
      data/
        models/
        datasources/
        repositories/
      presentation/
        screens/
        widgets/
  core/
test/
```

## How to Contribute

- Fork the repo
- Create a feature branch
- Submit a pull request
