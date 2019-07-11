class TestsController < Simpler::Controller

  def index
    render plain: "Hello :)"
  end

  def create

  end

  def show
    @test_id = params[:id]
  end

end
