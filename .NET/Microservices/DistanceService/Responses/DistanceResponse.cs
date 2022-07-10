namespace DistanceService.Responses
{
    public class DistanceResponse
    {
        public double Distance { get; private set; }

        public DistanceResponse(double distance)
        {
            Distance = distance;
        }
    }
}
