
class SMS

  def send_sms(body, numbers, origin = "573213270775")
    require 'zensend'

    client = ZenSend::Client.new("ZM2zt6_Jj43S_kguE5fz7Q")
    begin
      result = client.send_sms(
          originator: origin,
          numbers: numbers,
          originator_type: "msisdn",
          body: body
      )
    rescue ZenSend::ZenSendException => e
      puts e.http_code # http status code
      puts e.failcode # zensend error code (might be null)
      puts e.parameter # the parameter the failcode is related to (might be nil)
    rescue StandardError => e
      puts e # exception raised by net/http Errno::EHOSTUNREACH, Errno::ETIMEDOUT, Net::ReadTimeout, etc (http://ruby-doc.org/stdlib-2.2.2/libdoc/net/http/rdoc/Net/HTTP.html)
    end
  end
end