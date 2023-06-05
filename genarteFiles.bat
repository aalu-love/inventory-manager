@echo off

REM Create directory structure
mkdir lib
mkdir lib\models
mkdir lib\screens
mkdir lib\services
mkdir lib\utils
mkdir lib\widgets

REM Create main.dart file
echo. > lib\main.dart

REM Create models directory files
echo. > lib\models\item.dart

REM Create screens directory files
echo. > lib\screens\home_screen.dart
echo. > lib\screens\filter_screen.dart

REM Create services directory files
echo. > lib\services\csv_service.dart

REM Create utils directory files
echo. > lib\utils\constants.dart

REM Create widgets directory files
echo. > lib\widgets\item_card.dart

echo Project directories and files created successfully!
