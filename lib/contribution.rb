class Contribution
  attr_reader :entry, :definition, :id

  def initialize(attributes)
    @params = {:word => attributes}
    @id = attributes[:id]
    @entry = attributes[:entry]
    @definition = attributes[:definition]
  end

  def create
    conn.post("#{HOSTNAME}/words/",@params)
  end

  def self.delete(id)
    conn.delete("#{HOSTNAME}/words/#{id}",:id => id)
  end

  def self.update(params)
    conn.put("#{HOSTNAME}/words/#{params[:id]}",{:word => params})
  end

  def self.list
    response = conn.get("#{HOSTNAME}/words/")
    word_array = JSON.parse(response.body, :symbolize_names => true)
    word_array.map { |hash| Contribution.new(hash[:word]) }
  end

  private

  def conn
    Faraday.new(HOSTNAME)
  end

  def self.conn
    Faraday.new(HOSTNAME)
  end

end