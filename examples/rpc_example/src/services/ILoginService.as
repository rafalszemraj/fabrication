package services {
    import mx.rpc.AsyncToken;

    public interface ILoginService {
        function getLogins():AsyncToken;
    }
}