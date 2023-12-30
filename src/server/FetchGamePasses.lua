
  
local function FetchLiveOps()
    local HttpService = game:GetService("HttpService")

	local apiKey = script:GetAttribute("ApiKey")

	local ROBLOPS_URL = "https://bloxyops.com/api/GamePass/All"
	local HEADERS = {
		['X-Api-Key'] = apiKey
	}
	
	-- Now set parameters 
	
	-- Make the request to our endpoint URL
	local response = HttpService:GetAsync(ROBLOPS_URL, false, HEADERS)
	print(response)

    -- Parse the JSON response and store in a global variable
    local data = HttpService:JSONDecode(response)

    -- Information in the data table is dependent on the response JSON
    if data[1].id > 0 then
        print("data received")
        -- Process data here
    end

    for key, value in data do -- pseudocode
        print(value["summary"])
    end

    -- fire event to all clients
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    -- Get reference to remote event instance
    local remoteEvent = ReplicatedStorage:FindFirstChild("GamePassUpdate")

    -- Fire Event
    remoteEvent:FireAllClients(data)

    -- Now fetch game passes
    

    return data
end

return FetchLiveOps
