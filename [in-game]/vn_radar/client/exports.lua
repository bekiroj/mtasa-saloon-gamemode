local states = {}

function showAll()
	Radar.setVisible(true)
	states.radar = true
end

function setVisible(visible)
	if not visible then
		Radar.setVisible(false)	
	else
		Radar.setVisible(true)		
	end
end

function setRadarVisible(...)
	return Radar.setVisible(...)
end



-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://youtube.com/c/SparroWMTA/

-- Discord : https://discord.gg/DzgEcvy