package util

import (
	"fmt"
	"math/rand"
	"strings"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

// RandomInt generates a random integer between min and max
func RandomInt(min, max int) int {
	return min + rand.Intn(max-min+1)
}

// RandomString generates a random string of length n
func RandomString(n int) string {
	var sb strings.Builder
	for range n {
		sb.WriteByte(alphabet[rand.Intn(len(alphabet))])
	}
	return sb.String()
}

// RandomOwner generates a random owner name
func RandomOwner() string {
	return RandomString(6)
}

// RandomMoney generates a random amount of money
func RandomMoney() int64 {
	return int64(RandomInt(100, 1000))
}

// RandomCurrency generates a random currency
func RandomCurrency() string {
	currencies := supportedCurrencies
	return currencies[rand.Intn(len(currencies))]
}

// RandomEmail generates a random email
func RandomEmail() string {
	return fmt.Sprintf("%s@example.com", RandomString(6))
}
