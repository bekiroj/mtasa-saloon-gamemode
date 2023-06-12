Timer(function()
    setTime(20,45)
    local weather = getWeather()
    if weather == 15 then else
        setWeather(15)
        iprint("!WEATHER - apply")
    end
end, 4500, 0)