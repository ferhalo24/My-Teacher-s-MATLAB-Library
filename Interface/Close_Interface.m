function Close_Interface
global interface
if  ~isempty(interface)
    delete(interface);
end
end