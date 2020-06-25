module Cmor
  module Transports
    module Packs
      class ZipService < Base
        private

        def pack_and_attach!
          begin
            outgoing.start_packing!
            stringio = Zip::OutputStream.write_buffer do |zio|
              outgoing.exports.map(&:output).each do |attachment|
                zio.put_next_entry(attachment.filename)
                zio.write attachment.blob.download
              end
            end

            stringio.rewind

            @outgoing.output.attach(io: stringio, filename: "output.zip", content_type: "application/zip")
            outgoing.succeed_packing!
          rescue => e
            outgoing.failed_packing!
            raise e
          end
        end
      end
    end
  end
end