class SMS

  def self.send_sms(body, numbers, origin = "When will be the f2f meeting?")
    client = ZenSend::Client.new("ZM2zt6_Jj43S_kguE5fz7Q")
    result = client.send_sms(
        originator: origin,
        numbers: numbers,
        body: body
    )
  end
end