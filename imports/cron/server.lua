<<<<<<< HEAD
=======
--[[
    https://github.com/overextended/ox_lib

    This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

    Copyright © 2025 Linden <https://github.com/thelindat>
]]

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
lib.cron = {}

---@alias Date { year: number, month: number, day: number, hour: number, min: number, sec: number, wday: number, yday: number, isdst: boolean }
---@type Date
local currentDate = {}

setmetatable(currentDate, {
    __index = function(self, index)
        local newDate = os.date('*t') --[[@as Date]]
<<<<<<< HEAD

        for k, v in pairs(newDate) do
            self[k] = v
        end

        SetTimeout(1000, function() table.wipe(self) end)

=======
        for k, v in pairs(newDate) do
            self[k] = v
        end
        SetTimeout(1000, function() table.wipe(self) end)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        return self[index]
    end
})

---@class OxTaskProperties
<<<<<<< HEAD
---@field minute? number | string
---@field hour? number | string
---@field day? number | string
---@field month? number | string
---@field year? number | string
---@field weekday? number | string
=======
---@field minute? number|string|function
---@field hour? number|string|function
---@field day? number|string|function
---@field month? number|string|function
---@field year? number|string|function
---@field weekday? number|string|function
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@field job fun(task: OxTask, date: osdate)
---@field isActive boolean
---@field id number
---@field debug? boolean
<<<<<<< HEAD
=======
---@field lastRun? number
---@field maxDelay? number Maximum allowed delay in seconds before skipping (0 to disable)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9

---@class OxTask : OxTaskProperties
---@field expression string
---@field private scheduleTask fun(self: OxTask): boolean?
local OxTask = {}
OxTask.__index = OxTask

<<<<<<< HEAD
=======
local validRanges = {
    min = { min = 0, max = 59 },
    hour = { min = 0, max = 23 },
    day = { min = 1, max = 31 },
    month = { min = 1, max = 12 },
    wday = { min = 0, max = 7 },
}

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
local maxUnits = {
    min = 60,
    hour = 24,
    wday = 7,
    day = 31,
    month = 12,
}

<<<<<<< HEAD
--- Gets the amount of days in certain month
=======
local weekdayMap = {
    sun = 1,
    mon = 2,
    tue = 3,
    wed = 4,
    thu = 5,
    fri = 6,
    sat = 7,
}

local monthMap = {
    jan = 1, feb = 2, mar = 3, apr = 4,
    may = 5, jun = 6, jul = 7, aug = 8,
    sep = 9, oct = 10, nov = 11, dec = 12
}

---Returns the last day of the specified month
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@param month number
---@param year? number
---@return number
local function getMaxDaysInMonth(month, year)
    return os.date('*t', os.time({ year = year or currentDate.year, month = month + 1, day = -1 })).day --[[@as number]]
end

<<<<<<< HEAD
---@param value string | number | nil
---@param unit string
---@return string | number | false | nil
=======
---@param value string|number
---@param unit string
---@return boolean
local function isValueInRange(value, unit)
    local range = validRanges[unit]
    if not range then return true end
    return value >= range.min and value <= range.max
end

---@param value string
---@param unit string
---@return number|string|function|nil
local function parseCron(value, unit)
    if not value or value == '*' then return end

    if unit == 'day' and value:lower() == 'l' then
        return function()
            return getMaxDaysInMonth(currentDate.month, currentDate.year)
        end
    end

    local num = tonumber(value)
    if num then
        if not isValueInRange(num, unit) then
            error(("^1invalid cron expression. '%s' is out of range for %s^0"):format(value, unit), 3)
        end
        return num
    end

    if unit == 'wday' then
        local start, stop = value:match('(%a+)-(%a+)')
        if start and stop then
            start = weekdayMap[start:lower()]
            stop = weekdayMap[stop:lower()]
            if start and stop then
                if stop < start then stop = stop + 7 end
                return ('%d-%d'):format(start, stop)
            end
        end
        local day = weekdayMap[value:lower()]
        if day then return day end
    end

    if unit == 'month' then
        local months = {}
        for month in value:gmatch('[^,]+') do
            local monthNum = monthMap[month:lower()]
            if monthNum then
                months[#months + 1] = tostring(monthNum)
            end
        end
        if #months > 0 then
            return table.concat(months, ',')
        end
    end

    local stepMatch = value:match('^%*/(%d+)$')
    if stepMatch then
        local step = tonumber(stepMatch)
        if not step or step == 0 then
            error(("^1invalid cron expression. Step value cannot be %s^0"):format(step or 'nil'), 3)
        end
        return value
    end

    local start, stop = value:match('^(%d+)-(%d+)$')
    if start and stop then
        start, stop = tonumber(start), tonumber(stop)
        if not start or not stop or not isValueInRange(start, unit) or not isValueInRange(stop, unit) then
            error(("^1invalid cron expression. Range '%s' is invalid for %s^0"):format(value, unit), 3)
        end
        return value
    end

    local valid = true
    for item in value:gmatch('[^,]+') do
        local num = tonumber(item)
        if not num or not isValueInRange(num, unit) then
            valid = false
            break
        end
    end
    if valid then return value end

    error(("^1invalid cron expression. '%s' is not supported for %s^0"):format(value, unit), 3)
end

---@param value string|number|function|nil
---@param unit string
---@return number|false|nil
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
local function getTimeUnit(value, unit)
    local currentTime = currentDate[unit]

    if not value then
        return unit == 'min' and currentTime + 1 or currentTime
    end

<<<<<<< HEAD
=======
    if type(value) == 'function' then
        return value()
    end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    local unitMax = maxUnits[unit]

    if type(value) == 'string' then
        local stepValue = string.match(value, '*/(%d+)')

        if stepValue then
<<<<<<< HEAD
            -- */10 * * * * is equal to a list of 0,10,20,30,40,50
            -- best suited to factors of unitMax (excluding the highest and lowest numbers)
            -- i.e. for minutes - 2, 3, 4, 5, 6, 10, 12, 15, 20, 30
            for i = currentTime + 1, unitMax do
                -- if i is divisible by stepValue
                if i % stepValue == 0 then return i end
            end

            return stepValue + unitMax
        end

        local range = string.match(value, '%d+-%d+')

=======
            local step = tonumber(stepValue)
            for i = currentTime + 1, unitMax do
                if i % step == 0 then return i end
            end
            return step + unitMax
        end

        local range = string.match(value, '%d+-%d+')
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        if range then
            local min, max = string.strsplit('-', range)
            min, max = tonumber(min, 10), tonumber(max, 10)

            if unit == 'min' then
                if currentTime >= max then
                    return min + unitMax
                end
            elseif currentTime > max then
                return min + unitMax
            end

            return currentTime < min and min or currentTime
        end

        local list = string.match(value, '%d+,%d+')
<<<<<<< HEAD

        if list then
            for listValue in string.gmatch(value, '%d+') --[[@as number]] do
                listValue = tonumber(listValue)

                -- e.g. if current time is less than in the expression 0,10,20,45 * * * *
=======
        if list then
            local values = {}
            for listValue in string.gmatch(value, '%d+') do
                values[#values + 1] = tonumber(listValue)
            end
            table.sort(values)

            for i = 1, #values do
                local listValue = values[i]
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
                if unit == 'min' then
                    if currentTime < listValue then
                        return listValue
                    end
                elseif currentTime <= listValue then
                    return listValue
                end
            end

<<<<<<< HEAD
            -- if iterator failed, return the first value in the list
            return tonumber(string.match(value, '%d+')) + unitMax
=======
            return values[1] + unitMax
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        end

        return false
    end

    if unit == 'min' then
<<<<<<< HEAD
        return value <= currentTime and value + unitMax or value
    end

    return value < currentTime and value + unitMax or value
end

---Get a timestamp for the next time to run the task today.
=======
        return value <= currentTime and value + unitMax or value --[[@as number]]
    end

    return value < currentTime and value + unitMax or value --[[@as number]]
end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@return number?
function OxTask:getNextTime()
    if not self.isActive then return end

    local day = getTimeUnit(self.day, 'day')

<<<<<<< HEAD
    -- If current day is the last day of the month, and the task is scheduled for the last day of the month, then the task should run.
    if day == 0 then
        -- Should probably be used month from getTimeUnit, but don't want to reorder this code.
=======
    if day == 0 then
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        day = getMaxDaysInMonth(currentDate.month)
    end

    if day ~= currentDate.day then return end

    local month = getTimeUnit(self.month, 'month')
<<<<<<< HEAD

    if month ~= currentDate.month then return end

    local weekday = getTimeUnit(self.weekday, 'wday')

    if weekday ~= currentDate.wday then return end

    local minute = getTimeUnit(self.minute, 'min')

    if not minute then return end

    local hour = getTimeUnit(self.hour, 'hour')

=======
    if month ~= currentDate.month then return end

    local weekday = getTimeUnit(self.weekday, 'wday')
    if weekday and weekday ~= currentDate.wday then return end

    local minute = getTimeUnit(self.minute, 'min')
    if not minute then return end

    local hour = getTimeUnit(self.hour, 'hour')
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    if not hour then return end

    if minute >= maxUnits.min then
        if not self.hour then
            hour += math.floor(minute / maxUnits.min)
        end
<<<<<<< HEAD

=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        minute = minute % maxUnits.min
    end

    if hour >= maxUnits.hour and day then
        if not self.day then
            day += math.floor(hour / maxUnits.hour)
        end
<<<<<<< HEAD

        hour = hour % maxUnits.hour
    end

    return os.time({
=======
        hour = hour % maxUnits.hour
    end

    local nextTime = os.time({
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        min = minute,
        hour = hour,
        day = day or currentDate.day,
        month = month or currentDate.month,
        year = currentDate.year,
    })
<<<<<<< HEAD
end

---Get timestamp for next time to run task at any day.
=======

    if self.lastRun and nextTime - self.lastRun < 60 then
        if self.debug then
            lib.print.debug(('Preventing duplicate execution of task %s - Last run: %s, Next scheduled: %s'):format(
                self.id,
                os.date('%c', self.lastRun),
                os.date('%c', nextTime)
            ))
        end
        return
    end

    return nextTime
end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@return number
function OxTask:getAbsoluteNextTime()
    local minute = getTimeUnit(self.minute, 'min')
    local hour = getTimeUnit(self.hour, 'hour')
    local day = getTimeUnit(self.day, 'day')
    local month = getTimeUnit(self.month, 'month')
    local year = getTimeUnit(self.year, 'year')

<<<<<<< HEAD
    -- To avoid modifying getTimeUnit function, the day is adjusted here if needed.
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    if self.day then
        if currentDate.hour < hour or (currentDate.hour == hour and currentDate.min < minute) then
            day = day - 1
            if day < 1 then
                day = getMaxDaysInMonth(currentDate.month)
            end
        end

        if currentDate.hour > hour or (currentDate.hour == hour and currentDate.min >= minute) then
            day = day + 1
            if day > getMaxDaysInMonth(currentDate.month) or day == 1 then
                day = 1
                month = month + 1
            end
        end
    end

<<<<<<< HEAD
    -- Check if time will be in next year.
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    ---@diagnostic disable-next-line: assign-type-mismatch
    if os.time({ year = year, month = month, day = day, hour = hour, min = minute }) < os.time() then
        year = year and year + 1 or currentDate.year + 1
    end

    return os.time({
        min = minute < 60 and minute or 0,
        hour = hour < 24 and hour or 0,
        day = day or currentDate.day,
        month = month or currentDate.month,
        year = year or currentDate.year,
    })
end

function OxTask:getTimeAsString(timestamp)
    return os.date('%A %H:%M, %d %B %Y', timestamp or self:getAbsoluteNextTime())
end

---@type OxTask[]
local tasks = {}

function OxTask:scheduleTask()
    local runAt = self:getNextTime()

    if not runAt then
        return self:stop('getNextTime returned no value')
    end

    local currentTime = os.time()
    local sleep = runAt - currentTime

    if sleep < 0 then
<<<<<<< HEAD
        return self:stop(self.debug and ('scheduled time expired %s seconds ago'):format(-sleep))
=======
        if not self.maxDelay or -sleep > self.maxDelay then
            return self:stop(self.debug and ('scheduled time expired %s seconds ago'):format(-sleep))
        end

        if self.debug then
            lib.print.debug(('Task %s is %s seconds overdue, executing now due to maxDelay=%s'):format(
                self.id,
                -sleep,
                self.maxDelay
            ))
        end

        sleep = 0
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    end

    local timeAsString = self:getTimeAsString(runAt)

    if self.debug then
<<<<<<< HEAD
        print(('(%s) task %s will run in %d seconds (%0.2f minutes / %0.2f hours)'):format(timeAsString, self.id, sleep,
=======
        lib.print.debug(('(%s) task %s will run in %d seconds (%0.2f minutes / %0.2f hours)'):format(timeAsString, self.id, sleep,
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
            sleep / 60,
            sleep / 60 / 60))
    end

    if sleep > 0 then
        Wait(sleep * 1000)
<<<<<<< HEAD
    else -- will this even happen?
        Wait(1000)
=======
    else
        Wait(0)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        return true
    end

    if self.isActive then
        if self.debug then
<<<<<<< HEAD
            print(('(%s) running task %s'):format(timeAsString, self.id))
=======
            lib.print.debug(('(%s) running task %s'):format(timeAsString, self.id))
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        end

        Citizen.CreateThreadNow(function()
            self:job(currentDate)
<<<<<<< HEAD
        end)

        -- Wait(30000)

=======
            self.lastRun = os.time()
        end)

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        return true
    end
end

<<<<<<< HEAD
---Start an inactive task.
=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function OxTask:run()
    if self.isActive then return end

    self.isActive = true

    CreateThread(function()
        while self:scheduleTask() do end
    end)
end

function OxTask:stop(msg)
    self.isActive = false

    if self.debug then
        if msg then
<<<<<<< HEAD
            return print(('stopping task %s (%s)'):format(self.id, msg))
        end

        print(('stopping task %s'):format(self.id))
    end
end

---@param value string
---@return number | string | nil
local function parseCron(value, unit)
    if not value or value == '*' then return end

    local num = tonumber(value)

    if num then return num end

    if unit == 'wday' then
        if value == 'sun' then return 1 end
        if value == 'mon' then return 2 end
        if value == 'tue' then return 3 end
        if value == 'wed' then return 4 end
        if value == 'thu' then return 5 end
        if value == 'fri' then return 6 end
        if value == 'sat' then return 7 end
    end

    if unit == 'month' then
        if value == 'jan' then return 1 end
        if value == 'feb' then return 2 end
        if value == 'mar' then return 3 end
        if value == 'apr' then return 4 end
        if value == 'may' then return 5 end
        if value == 'jun' then return 6 end
        if value == 'jul' then return 7 end
        if value == 'aug' then return 8 end
        if value == 'sep' then return 9 end
        if value == 'oct' then return 10 end
        if value == 'nov' then return 11 end
        if value == 'dec' then return 12 end
    end

    if getTimeUnit(value, unit) then return value end

    error(("^1invalid cron expression. '%s' is not supported for %s^0"):format(value, unit), 3)
end

=======
            return lib.print.debug(('stopping task %s (%s)'):format(self.id, msg))
        end

        lib.print.debug(('stopping task %s'):format(self.id))
    end
end

>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
---@param expression string A cron expression such as `* * * * *` representing minute, hour, day, month, and day of the week.
---@param job fun(task: OxTask, date: osdate)
---@param options? { debug?: boolean }
---Creates a new [cronjob](https://en.wikipedia.org/wiki/Cron), scheduling a task to run at fixed times or intervals.
---Supports numbers, any value `*`, lists `1,2,3`, ranges `1-3`, and steps `*/4`.
---Day of the week is a range of `1-7` starting from Sunday and allows short-names (i.e. sun, mon, tue).
<<<<<<< HEAD
=======
---@note maxDelay: Maximum allowed delay in seconds before skipping (0 to disable)
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
function lib.cron.new(expression, job, options)
    if not job or type(job) ~= 'function' then
        error(("expected job to have type 'function' (received %s)"):format(type(job)))
    end

    local minute, hour, day, month, weekday = string.strsplit(' ', string.lower(expression))
    ---@type OxTask
    local task = setmetatable(options or {}, OxTask)

    task.expression = expression
    task.minute = parseCron(minute, 'min')
    task.hour = parseCron(hour, 'hour')
    task.day = parseCron(day, 'day')
    task.month = parseCron(month, 'month')
    task.weekday = parseCron(weekday, 'wday')
    task.id = #tasks + 1
    task.job = job
<<<<<<< HEAD
=======
    task.lastRun = nil
    task.maxDelay = task.maxDelay or 1
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
    tasks[task.id] = task
    task:run()

    return task
end

-- reschedule any dead tasks on a new day
lib.cron.new('0 0 * * *', function()
    for i = 1, #tasks do
        local task = tasks[i]
<<<<<<< HEAD

=======
>>>>>>> b4e3bcdad75f91eaa6d4e75063de4a281ebd36d9
        if not task.isActive then
            task:run()
        end
    end
end)

return lib.cron
