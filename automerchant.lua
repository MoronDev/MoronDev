local function purchaseFromMerchant(merchantType, quantity)
    local args = {
        [1] = merchantType,
        [2] = quantity
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Merchant_RequestPurchase"):InvokeServer(unpack(args))
end

for i = 1, 6 do
    purchaseFromMerchant("RegularMerchant", i)
end
