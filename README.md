# cordova-plugin-skadnetwork

Cordova plugin to update SKAdNetwork postback conversion values for iOS attribution.

## Installation

```bash
cordova plugin add /path/to/cordova-plugin-skadnetwork
```

## Usage

### Lock Conversion Value to 63 (Recommended for claiming install credit)

```javascript
SKAdNetwork.lockConversionValue(
    function(success) {
        console.log('SKAdNetwork: ' + success);
    },
    function(error) {
        console.error('SKAdNetwork Error: ' + error);
    }
);
```

### Update Conversion Value (0-63)

```javascript
SKAdNetwork.updateConversionValue(
    63, // value between 0-63
    function(success) {
        console.log('SKAdNetwork: ' + success);
    },
    function(error) {
        console.error('SKAdNetwork Error: ' + error);
    }
);
```

### Update with Coarse Value (iOS 16.1+)

```javascript
SKAdNetwork.updatePostbackConversionValue(
    63,      // fine conversion value (0-63)
    'high',  // coarse value: 'low', 'medium', or 'high'
    true,    // lockWindow: lock the conversion window
    function(success) {
        console.log('SKAdNetwork: ' + success);
    },
    function(error) {
        console.error('SKAdNetwork Error: ' + error);
    }
);
```

### Register App for Attribution

```javascript
SKAdNetwork.registerAppForAttribution(
    function(success) {
        console.log('SKAdNetwork: ' + success);
    },
    function(error) {
        console.error('SKAdNetwork Error: ' + error);
    }
);
```

## iOS Version Support

- **iOS 14.0+**: Basic `updateConversionValue()` support
- **iOS 15.4+**: Async `updatePostbackConversionValue()` with completion handler
- **iOS 16.1+**: Full support with coarse conversion values and lock window

## Conversion Values

SKAdNetwork uses conversion values from 0-63 to indicate user engagement:
- **63**: Highest value user (e.g., made a purchase)
- **0**: Lowest value user

Setting the value to 63 immediately after install is a common strategy to claim attribution credit.
