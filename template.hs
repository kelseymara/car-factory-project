import System.IO
import Text.Read (readMaybe)
import Text.XHtml (frame)

-- Handle user input selection
getUserSelection :: String -> [String] -> IO String
getUserSelection category options = do
    putStrLn $ "\nSelect a " ++ category ++ ":"
    mapM_ putStrLn $ zipWith (\i option -> show i ++ ". " ++ option) [1..] options
    getValidSelection
  where
    getValidSelection :: IO String
    getValidSelection = do
        input <- getLine
        case readMaybe input :: Maybe Int of
            Just n | n > 0 && n <= length options -> return $ options !! (n - 1)
            _ -> do
                putStrLn "Invalid selection, please try again."
                getValidSelection
-- Filter package options            
filterPackageOptions :: String -> [String]
filterPackageOptions frame
    | frame == "SUV" || frame == "Truck" = ["Sport", "Towing", "Luxury", "Custom"]
    | otherwise = ["Sport", "Luxury", "Custom"]

-- Filter engine options 
filterEngineOptions :: String -> [String]
filterEngineOptions package
    | package == "Sport" = ["V6", "V6 Turbo", "V8"]
    | package == "Towing" = ["V6","V8","Electric"]
    | otherwise = ["4 Cylinder","V6","V8","Electric"]

-- Filter transmission options 
-- Electric engines are limited exclusively to a 3-Speed Automatic transmission
-- A Dual-Gate transmission is exclusive to Coupes, only if the Sport package has been selected or the user is creating a Custom model
filterTransmissionOptions :: String -> String -> String -> [String]
filterTransmissionOptions engine frame package
    | engine == "Electric" = ["3-Speed Automatic"]
    | frame == "Coupe" && (package == "Sport" || package == "Custom") = ["3-Speed Automatic", "4-Speed Manual", "CVT", "Dual-Gate"]
    | otherwise = ["3-Speed Automatic", "4-Speed Manual", "CVT"]

-- filter drivetrain options 
filterDrivetrainOptions :: String -> [String]
filterDrivetrainOptions package
    | package == "Towing" = ["Four-Wheel","All-Wheel"]
    | package == "Sport"= ["Front-Wheel","Rear-Wheel","All-Wheel"]
    | otherwise = ["Front-Wheel","All-Wheel"]

-- display manager
displaySelections :: [String] -> IO ()
displaySelections selections = do 
    putStrLn "\n- - - - - -\n Your custom car options:" 
    mapM_ putStrLn $ zipWith (\category selection -> category ++ ": " ++ selection) ["Frame", "Package", "Engine", "Transmission", "Drive Train"] selections

main :: IO ()
main = do
    hSetBuffering stdout NoBuffering
    putStrLn "Welcome to the Morristown Car Factory! Let's build a car!"

    -- Define using let each of the other option categories
    let category= "frame"
    let frameOptions= ["Coupe" , "Sedan","Truck","SUV"]
    frameChoice <- getUserSelection category frameOptions 

    let category="package"
    -- Filter package based on frameChoice
    let filteredPackageOptions = filterPackageOptions frameChoice
    packageChoice <- getUserSelection category filteredPackageOptions
    
    let category="engine"
    let filteredEngineOptions = filterEngineOptions packageChoice
    engineChoice <- getUserSelection category filteredEngineOptions

    let category="transmission"
    let filteredTransmissionOptions = filterTransmissionOptions engineChoice frameChoice packageChoice
    transmissionChoice <- getUserSelection category filteredTransmissionOptions

    let category="drivetrain"
    let filteredDrivetrainOptions= filterDrivetrainOptions packageChoice
    drivetrainChoice <- getUserSelection category filteredDrivetrainOptions

    -- Display the user's car build using a dedicated display function
    displaySelections [frameChoice, packageChoice,engineChoice,transmissionChoice,drivetrainChoice]
    
    return()