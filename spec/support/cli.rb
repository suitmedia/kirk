module SpecHelpers
  attr_reader :stdout, :stderr, :stdin, :pid, :exit_status

  def kirk(cmd = "")
    IO.popen4("kirk #{cmd}") do |pid, stdin, stdout, stderr|
      @stdout, @stderr, @stdin, @pid = stdout, stderr, stdin, pid

      yield if block_given?

      Process.kill("HUP", pid) rescue nil
    end

    @exit_status = $?.exitstatus
  ensure
    @stdout, @stderr, @stdin, @pid = nil, nil, nil, nil
  end
end
