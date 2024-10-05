function dummy() end

function readCallback(req)
    if req.is_done and not req.is_error then
        local currNum = tonumber(req.text)
        if currNum then
            WebRequest.put('https://tts-db.firebaseio.com/modLoadCount.json', tostring(currNum+1), self, 'dummy')
        end
    end
end

function onLoad(save_state)
    self.interactable = false
    self.lock()
    self.tooltip = false
    WebRequest.get('https://tts-db.firebaseio.com/modLoadCount.json', self, 'readCallback')
end