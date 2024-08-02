-- console_handler\lua\autorun\console_handler.lua

-- Определяем функцию для отправки сообщений в чат
local function SendChatMessage(player, message)
    player:ChatPrint(message)
end

-- Функция для обработки команды
local function HandleCommand(ply, command)
    local args = string.Explode(" ", command)
    local commandName = args[1]
    local commandArgs = table.concat(args, " ", 2)

    -- Проверяем команду на блокировку
    local blockedCommands = {
        "exit", -- Пример заблокированной команды
        "quit", -- Добавьте другие команды, которые нужно заблокировать
    }

    if table.HasValue(blockedCommands, commandName) then
        SendChatMessage(ply, "Ошибка: Команда \"" .. commandName .. "\" заблокирована для выполнения.")
        return
    end

    -- Выполнение команды через RunConsoleCommand
    if commandName and commandName ~= "" then
        if commandArgs and commandArgs ~= "" then
            RunConsoleCommand(commandName, commandArgs)
            SendChatMessage(ply, "Команда \"" .. commandName .. "\" выполнена с аргументами: " .. commandArgs)
        else
            RunConsoleCommand(commandName)
            SendChatMessage(ply, "Команда \"" .. commandName .. "\" выполнена.")
        end
    else
        SendChatMessage(ply, "Ошибка: Пустая команда.")
    end
end

-- Хук для обработки сообщений чата
hook.Add("PlayerSay", "ChatCommands", function(ply, text, team)
    -- Игнорируем сообщения, не начинающиеся с "/"
    if string.sub(text, 1, 1) == "/" then
        -- Убираем "/" из команды
        local command = string.sub(text, 2)

        -- Проверяем, что команда не пуста
        if command and command ~= "" then
            HandleCommand(ply, command)
        else
            -- Отправляем сообщение о пустой команде
            SendChatMessage(ply, "Ошибка: Пустая команда.")
        end

        -- Возвращаем пустую строку, чтобы не отображать команду в чате
        return ""
    end
end)



/*
| Copyright © diopop1 - 2024 |

[ diopop1 - development. ]
[ ChatGPT - assistance in writing code. ]

All rights reserved, but you can improve the addon and release it as an improved version but with me as the author of the original addon.
*/