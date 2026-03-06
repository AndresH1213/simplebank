package util

import "slices"

var supportedCurrencies = []string{"USD", "EUR", "CAD", "GBP", "JPY"}

func IsSupportedCurrency(currency string) bool {
	return slices.Contains(supportedCurrencies, currency)
}
