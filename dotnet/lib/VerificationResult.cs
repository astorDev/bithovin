namespace Bithovin;

public record VerificationResult(bool Valid, Exception? Exception = null)
{
    public static implicit operator VerificationResult(bool valid) => new(valid);
    public static implicit operator VerificationResult(Exception ex) => new (false, ex);

    public static implicit operator bool(VerificationResult res) => res.Valid;

    public static VerificationResult From(Func<bool> verification)
    {
        try
        {
            return verification();
        }
        catch (Exception ex)
        {
            return ex;
        }
    }
}
