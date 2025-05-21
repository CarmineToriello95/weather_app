# Weather App

The app shows the weather for a given city. 
By default, the app shows the weather for Berlin. However, there is the possibility to search for other cities thanks to a search function. In particular, the app:

- Shows a loading indicator when fetching the data.
- Shows a list of weather item, each one including day of the week abbreviation, weather condition
image and temperature range.
- Shows the details of a selected daily weather, including day of the week, weather condition name and image, city, current temperature, humidity, pressure, and wind.
- When selecting a different weather item, it updates the details shown.
- When performing the pull to refresh gesture, it refreshes weather information.
- When fetching the data fails, it shows an error screen with a retry button.
- Allows to change the temperature's unit (C/F).
- Supports horizontal and vertical layouts.
- Allows to fetch the weather for a different city thanks to a search functionality.

## Api Used

The following APIs has been used to fetch the data:
- **weather data:** free plan api [5 Day / 3 Hour Forecast](https://openweathermap.org/forecast5), provided by [OpenWeatherMap](https://openweathermap.org).
  - Api call:  api.openweathermap.org/data/2.5/forecast?q={city name}&appid={API key}
- **weather images:** [weather icons](https://openweathermap.org/weather-conditions), provided by [OpenWeatherMap](https://openweathermap.org).
  - Api call: openweathermap.org/img/wn/{icon}@2x.png

For testing purposes, the API key is temporarily hardcoded within the codebase.

### Note
The OpenWeatherMap 5 Day / 3 Hour Forecast API provides weather forecast data in 3-hour intervals for the next 5 days.<br>In this application, the daily weather is extracted by selecting one forecast entry per day at the same time of day. This approach ensures consistency across days. <br>Notably, the first element returned by the API corresponds to the forecast time closest to the moment the data is fetched. This means that the initial forecast entry aligns closely with the current time,
 
## Development Info

- Built with Flutter version: 3.29.3
- Minimum required Dart version: 3.7.2
- Development device: iPhone 15 Simulator with iOS 17

## App Preview

https://github.com/user-attachments/assets/302be789-e787-44cd-9b58-7fed0d503519

<br> Horizontal layout <br>

<img width="707" alt="Screenshot 2025-05-21 at 08 34 18" src="https://github.com/user-attachments/assets/73387823-5e09-4f88-a50d-f3ae0b2a86dd" />

## Implementation

The project has been implemented following the [clean code architecture described by uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html), structured into three main layers within each feature:

- `presentation/` – UI widgets and state managemen. The **BLoC** pattern has been used for state management.
- `domain/` – Business logic, use cases, and abstract repository interfaces
- `data/` – Models, data sources (e.g., APIs, local storage), and repository implementations

The reason is because this architecture promotes clear separation of concerns, scalability, and testability.

Additionally, there is a `core/` folder used for:

- Shared logic and utilities
- Common base classes, interfaces, and helper functions used across features.

Therefore, the lib folder is organized as follows:

- `lib/`
  - `core/`
  - `features/` - Weather feature is here
  - `main.dart` — Application entry point
  - `di_config.dart` — Dependency injection setup
 
The tests folder mirrors the structure of the lib folder:

- `test/`
  - `core/` — Contains mocked object used in the tests
  - `features/` — Tests corresponding to `lib/feature`. Here you can find unit and widget tests.
  - `fixtures/` - Contains static test resources such as JSON files used to mock API responses and simulate external data during testing.
