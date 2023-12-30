-- cache data here
local headers

local function FetchGamePasses()
    local HttpService = game:GetService("HttpService")
	local GAME_PASS_URL = "https://bloxyops.com/api/GamePass/All"
    
	-- Make the request to our endpoint URL
	local response = HttpService:GetAsync(GAME_PASS_URL, false, headers)
    local gamePassData = HttpService:JSONDecode(response)

    return gamePassData
end

local function FetchEvents()
    local HttpService = game:GetService("HttpService")
	local EVENTS_URL = "https://bloxyops.com/api/Event/Active"

	-- Make the request to our endpoint URL
	local response = HttpService:GetAsync(EVENTS_URL, false, headers)
    local eventsData = HttpService:JSONDecode(response)

    return eventsData
end

local function FetchLiveOps()

	local apiKey = script:GetAttribute("ApiKey")

	headers = {
		['X-Api-Key'] = apiKey
	}

    -- Parse the JSON response and store in a global variable
    local data = FetchEvents(headers)

    -- fire event to all clients
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    -- Get reference to remote event instance
    local remoteEvent = ReplicatedStorage:FindFirstChild("EventUpdate")

    -- Fire Event
    remoteEvent:FireAllClients(data)

    -- Now fetch game passes
    local gamePassData = FetchGamePasses(headers)

    -- Get reference to remote event instance
    local remoteEvent = ReplicatedStorage:FindFirstChild("GamePassUpdate")

    -- Fire Event
    remoteEvent:FireAllClients(gamePassData)

    return data
end

return
{
    FetchLiveOps = FetchLiveOps,
    FetchGamePasses = FetchGamePasses,
    FetchEvents = FetchEvents
}