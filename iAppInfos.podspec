Pod::Spec.new do |s|
        s.name         = 'iAppInfos'
        s.version = '0.0.1'
        s.requires_arc = true
        s.author = {
                'Morissard Jérome' => 'morissardj@gmail.com'
        }
        s.ios.deployment_target = '5.0'
        s.summary = '.'
        s.license      = { :type => 'MIT' }
        s.homepage = 'https://github.com/leverdeterre/iAppInfos'
        s.source = {
        :git => 'https://github.com/leverdeterre/iAppInfos.git',
        :tag => "0.0.1"
        }
        s.source_files = 'iAppInfos/iAppInfos/iAppInfos/*'
end
