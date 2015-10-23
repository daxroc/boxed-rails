class PoiseApplicationRuby::Resources::Ruby::Resource < PoiseRuby::Resources::RubyRuntime::Resource
  def gem_binary(*args, &block)
    self.class.superclass.instance_method(:gem_binary).bind(self).call(*args, &block)
  end
end
