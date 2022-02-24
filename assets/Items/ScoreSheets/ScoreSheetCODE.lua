imageSet = {    'https://i.imgur.com/yIcjkN8.png',
                
				'https://i.imgur.com/98ixr9q.png',
				'https://i.imgur.com/xXL9r3J.png',
				'https://i.imgur.com/xXL9r3J.png',
				'https://i.imgur.com/mnLdzAr.png',
				'https://i.imgur.com/R8IFeMk.png',
				'https://i.imgur.com/nELsdz9.png',
				'https://i.imgur.com/D87qJXM.png',
				'https://i.imgur.com/fGrdWL8.png',
				'https://i.imgur.com/nbAHa5C.png',
				'https://i.imgur.com/LAb4hP1.png',
				
				'https://i.imgur.com/hFZGFoB.png',
				'https://i.imgur.com/KlzuyUX.png',
				'https://i.imgur.com/JUQa8s2.png',
				'https://i.imgur.com/seUXRlq.png',
				'https://i.imgur.com/JbKweGl.png',
				'https://i.imgur.com/j92Lu6p.png',
				'https://i.imgur.com/mu8s5Tu.png',
				'https://i.imgur.com/EGIxtnx.png',
				'https://i.imgur.com/4aXanjv.png',
				'https://i.imgur.com/2IySa1R.png',
				
				'https://i.imgur.com/3Tql6Kz.png',
				'https://i.imgur.com/UCFoie7.png',
				'https://i.imgur.com/jz2QJ3e.png',
				'https://i.imgur.com/d1vKxn4.png',
				'https://i.imgur.com/kuRmpWQ.png',
				'https://i.imgur.com/2GBRRpR.png',
				'https://i.imgur.com/vPbUumA.png',
				'https://i.imgur.com/FgEm0eJ.png',
				'https://i.imgur.com/nldf48v.png',
			}

function onLoad()
    -- Restore current image index
    currImage = tonumber(self.script_state) or 1
    self.lock()
    self.interactable = false
    self.tooltip = false
	
	self.createButton({
        label="+1", click_function="click_PlusOne",function_owner=self, position={2,1,0},height=400, width=1200, font_size=150
    })

  self.createButton({
        label="-1", click_function="click_SubOne",function_owner=self, position={-2,1,0},height=400, width=1200, font_size=150
    })
end

function click_PlusOne()
    deleteAll()
    -- Increment image index
    local nextImage = currImage + 1
    if nextImage > #imageSet then
        nextImage = 1
    end

    -- Reload self with the new image and save the index
    local custom = self.getCustomObject()
    custom.diffuse = imageSet[nextImage]
    self.setCustomObject(custom)
    local newSelf = self.reload()
    newSelf.script_state = nextImage
end

function click_SubOne()
    deleteAll()
    -- Increment image index
    local nextImage = currImage - 1
    if nextImage == 0 then
        nextImage = #imageSet
    end

    -- Reload self with the new image and save the index
    local custom = self.getCustomObject()
    custom.diffuse = imageSet[nextImage]
    self.setCustomObject(custom)
    local newSelf = self.reload()
    newSelf.script_state = nextImage
end