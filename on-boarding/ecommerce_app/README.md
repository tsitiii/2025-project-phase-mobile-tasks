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

- **Domain Layer:** Entities, repositories, usecases
- **Data Layer:** Models, repository implementations, data sources
- **Presentation Layer:** UI widgets, screens

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
      data/
      presentation/
    number_trivia/
      domain/
      data/
      presentation/
  core/
test/
```

## How to Contribute

- Fork the repo
- Create a feature branch
- Submit a pull request
