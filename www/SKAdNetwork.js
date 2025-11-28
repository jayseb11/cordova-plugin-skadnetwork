var exec = require('cordova/exec');

var SKAdNetwork = {
    /**
     * Update the SKAdNetwork conversion value (0-63)
     * @param {number} conversionValue - Value between 0 and 63
     * @param {function} success - Success callback
     * @param {function} error - Error callback
     */
    updateConversionValue: function(conversionValue, success, error) {
        exec(success, error, 'SKAdNetworkPlugin', 'updateConversionValue', [conversionValue]);
    },

    /**
     * Update postback conversion value with coarse value (iOS 16.1+)
     * @param {number} conversionValue - Value between 0 and 63
     * @param {string} coarseValue - 'low', 'medium', or 'high'
     * @param {boolean} lockWindow - Whether to lock the conversion window
     * @param {function} success - Success callback
     * @param {function} error - Error callback
     */
    updatePostbackConversionValue: function(conversionValue, coarseValue, lockWindow, success, error) {
        exec(success, error, 'SKAdNetworkPlugin', 'updatePostbackConversionValue', [conversionValue, coarseValue, lockWindow]);
    },

    /**
     * Lock the conversion value to 63 (maximum value indicating high-value user)
     * This is useful to immediately claim credit for the install.
     * @param {function} success - Success callback
     * @param {function} error - Error callback
     */
    lockConversionValue: function(success, error) {
        exec(success, error, 'SKAdNetworkPlugin', 'lockConversionValue', []);
    },

    /**
     * Register app for SKAdNetwork attribution
     * @param {function} success - Success callback
     * @param {function} error - Error callback
     */
    registerAppForAttribution: function(success, error) {
        exec(success, error, 'SKAdNetworkPlugin', 'registerAppForAttribution', []);
    }
};

module.exports = SKAdNetwork;
