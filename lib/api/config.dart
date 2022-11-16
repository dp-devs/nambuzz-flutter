final Map<String, Environment> envs = {
  'post': Environment(
    endPointUrl: 'postnamebuzz.herokuapp.com',
    secured: true,
    additionalPath: '',
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
