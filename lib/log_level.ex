defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do 
      level == 0 -> cond do 
        legacy? -> :unknown
        true -> :trace
      end
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 -> cond do
        legacy? -> :unknown
        true -> :fatal
      end
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    alert_label = to_label(level, legacy?)
    cond do
      alert_label == :error || alert_label == :fatal -> :ops
      alert_label == :unknown && legacy? -> :dev1
      alert_label == :unknown -> :dev2
      true -> false
    end
  end
end
