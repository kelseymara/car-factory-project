# Overview
Project created: Spring 2024, CS 355 Principles of Programming Languages

This project uses the functional programming language Haskell to create an "assembly line" program where users users are able to select different options to generate a custom car.

## Features
The program allows users to customize their car by choosing options in the following categories:

### Car Options

| **Category**      | **Options**                                       |
|--------------------|---------------------------------------------------|
| **Frame**         | Coupe, Sedan, Truck, SUV                          |
| **Package**       | Sport, Towing, Luxury, Custom                     |
| **Engine**        | 4 Cylinder, V6, V6 Turbo, V8, Electric            |
| **Transmission**  | 3-Speed Automatic, 4-Speed Manual, CVT, Dual-Gate |
| **Drivetrain**    | Front-Wheel, Rear-Wheel, Four-Wheel, All-Wheel    |

## Rules
The program enforces the following rules to dynamically show or hide options based on the user's selections:

1. **Towing package** is only available for **SUVs** and **Trucks**.
2. **V6 Turbo** is only available if users select the **Sport** package.
3. The **4 Cylinder** engine option is not available for **Sport** or **Towing** packages.
4. **Electric** engines are not available for the **Sport** package.
5. **Electric** engines are limited exclusively to a **3-Speed Automatic** transmission.
6. A **Dual-Gate** transmission is exclusive to **Coupes**, only if the **Sport** package has been selected or the user is creating a **Custom** model.
7. The **Towing** package requires either **Four-Wheel** or **All-Wheel** drive.
8. **Rear-Wheel** drive is exclusive to the **Sport** package.
9. **Four-Wheel** drive is only available to **Towing** packages.

## How to run
1. CD into directory with template.hs file

2. Run this command to compile main and link project: 
```terminal
ghc -o project-name template.hs
```

3. Run this command to run: 
```terminal
./project-name
```
