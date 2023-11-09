function split (message, sintax)
	local t={}
    for str in string.gmatch(message, "([^"..sintax.."]+)") do
            table.insert(t, str)
    end
    return t
end