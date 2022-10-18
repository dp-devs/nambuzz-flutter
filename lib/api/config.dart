final Map<String, Environment> envs = {
  'dev': Environment(
    endPointUrl: 'com.whistle.app',
    secured: true,
    additionalPath: '/api/user/',
    port: '',
  ),
  'stag': Environment(
    endPointUrl: 'namebuzz.herokuapp.com',
    secured: true,
    additionalPath: '',
    port: '',
  ),
};

class Environment {
  String endPointUrl;
  bool secured;
  String additionalPath;
  String port;

  Environment({
    required this.endPointUrl,
    required this.secured,
    required this.additionalPath,
    required this.port,
  });
}
