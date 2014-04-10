json.array!(@audios) do |audio|
  json.extract! audio, :id, :filename
  json.url audio_url(audio, format: :json)
end
